# frozen_string_literal: true

require_relative 'piece'
require_relative 'square'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'board'

# A hopefully near-blackbox match of chess
# but which exposes the board for easy access.
class Game
  attr_reader :board, :current_player, :moves

  def initialize
    @board = Board.new
    setup_board
    @current_player = 'white'
    @moves = []
  end

  def move(str)
    newgame = Game.new
    @moves.each { |move| newgame.move_unvalidated(move) }
    newgame.move_unvalidated(str)

    return if newgame.checking? || newgame.current_player == @current_player ||
              (str.include?('+') && !newgame.check?)

    # I have NO clue why check and checking check for opposite checks

    @board = newgame.board
    @moves << str
    @current_player = newgame.current_player
  end

  def move_unvalidated(str)
    return castle(str) if str[0] == 'O'

    dst = find_destination(str)
    return unless dst && @board.valid_coords?(dst)

    src = find_source(dst, str)

    return unless src && @board.valid_coords?(src)

    @board.info_at(src, :moven?, @moves.length)
    @board.move_piece(src, dst)
    @moves << str
    @current_player = %w[white black].find { |color| color != @current_player }
  end

  def friend?(coords)
    @board.board[coords[0]][coords[1]].piece&.black ==
      (@current_player == 'black')
  end

  def enemy?(coords)
    @board.board[coords[0]][coords[1]].piece&.black ==
      (@current_player == 'white')
  end

  def qualifies?(qualifier, coords, type)
    if qualifier.is_a?(Array)
      return qualifier == coords && @board.valid_coords?(coords) &&
             @board.board[coords[0]][coords[1]].piece.is_a?(type) &&
             friend?(coords)
    end

    (qualifier.nil? || (qualifier.ord - 'a'.ord) == coords[1] ||
    ((8 - qualifier.to_i) == coords[0])) &&
      @board.valid_coords?(coords) && @board.board[coords[0]][coords[1]].piece.is_a?(type) && friend?(coords)
  end

  def forwards
    (@current_player == 'white' ? -1 : 1)
  end

  def check?
    king_location = find_king
    @current_player = %w[white black].find { |player| player != @current_player }
    ('a'..'h').each do |file|
      ('1'..'8').each do |rank|
        piece_type = @board.board[8 - rank.to_i][file.ord - 'a'.ord].piece&.letter
        next unless piece_type

        str = "#{piece_type}#{file}#{rank}x#{king_location}"
        if find_source(find_destination(str), str)
          @current_player = %w[white black].find { |player| player != @current_player }
          return true
        end
      end
    end
    @current_player = %w[white black].find { |player| player != @current_player }
    false
  end

  def checking?
    @current_player = %w[white black].find { |player| player != @current_player }
    king_location = find_king
    @current_player = %w[white black].find { |player| player != @current_player }
    ('a'..'h').each do |file|
      ('1'..'8').each do |rank|
        piece_type = @board.board[8 - rank.to_i][file.ord - 'a'.ord].piece&.letter
        next unless piece_type

        str = "#{piece_type}#{file}#{rank}x#{king_location}"
        return true if find_source(find_destination(str), str)
      end
    end
    false
  end

  def able_to_move?
    list_of_legal_moves = list_legal_moves
    list_of_legal_moves.each do |legal_move|
      virtual_game = Game.new
      @moves.each { |past_move| virtual_game.move past_move }
      virtual_game.move legal_move
      return true if virtual_game.current_player != @current_player
    end
    false
  end

  private

  def setup_board
    clear_all_pieces
    setup_white_pieces
    setup_black_pieces
  end

  def clear_all_pieces
    @board = Board.new
  end

  def setup_white_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |index|
      @board.place_piece([6, index], Pawn.new(black: false))
      @board.place_piece([7, index], back_row[index].new(black: false))
    end
  end

  def setup_black_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |index|
      @board.place_piece([0, index], back_row[index].new(black: true))
      @board.place_piece([1, index], Pawn.new(black: true))
    end
  end

  def find_source(dst, str)
    piececlass = { R: Rook, N: Knight, B: Bishop, Q: Queen, K: King }[str[0].to_sym]
    piececlass ? piececlass.source(dst, str, self) : Pawn.source(dst, str, self)
  end

  def find_destination(str)
    dst = (%w[R N B R Q K].include?(str[0]) ? Piece : Pawn).destination(str, self)
    dst if dst.is_a?(Array) && (0..7).cover?(dst[0]) && (0..7).cover?(dst[1])
  end

  def find_king
    (0..7).each do |row|
      (0..7).each do |col|
        return ('a'.ord + col).chr + (8 - row).to_s if friend?([row, col]) &&
                                                       @board.board[row][col]
                                                             .piece.is_a?(King)
      end
    end
  end

  def castle(str)
    row = @current_player == 'white' ? 7 : 0
    return unless @board.board[row][4].piece.is_a?(King) && ['O-O-O', 'O-O'].include?(str)

    return unless str == 'O-O' ? castle_kingside(row) : castle_queenside(row)

    @moves << str
    @current_player = %w[white black].find { |color| color != @current_player }
  end

  def castle_kingside(row)
    return false if @board.info_at([row, 7], :moven?) || @board.info_at([row, 4], :moven?)

    return false unless find_source([row, 5], @current_player == 'white' ? 'Rh1f1' : 'Rh8f8')

    @board.move_piece([row, 7], [row, 5])
    @board.move_piece([row, 4], [row, 6])

    @board.info_at([row, 5], :moven?, @moves.length)
    @board.info_at([row, 6], :moven?, @moves.length)

    true
  end

  def castle_queenside(row)
    return false if @board.info_at([row, 0], :moven?) || @board.info_at([row, 4], :moven?)

    return false unless find_source([row, 3], @current_player == 'white' ? 'Ra1f1' : 'Ra8f8')

    @board.move_piece([row, 0], [row, 3])
    @board.move_piece([row, 4], [row, 2])

    @board.info_at([row, 2], :moven?, @moves.length)
    @board.info_at([row, 3], :moven?, @moves.length)

    true
  end

  def list_legal_moves
    list_of_legal_moves = []
    8.times do |i|
      8.times do |j|
        list_of_legal_moves += @board.board[i][j].piece.class.legal_moves([i, j], self) if friend?([i, j])
      end
    end
    list_of_legal_moves
  end
end
