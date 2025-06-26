# frozen_string_literal: true

require_relative 'piece'

# King
class King < Piece
  def initialize(black: false)
    super(black ? '♚' : '♔', 'K', black: black)
  end

  def self.source(dst, str, game)
    qualifier = find_qualifier(str)
    moves = [[0, 1], [1, 1], [1, 0], [1, -1],
             [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    srcs = [nil]
    moves.each do |move|
      src = [move[0] + dst[0], move[1] + dst[1]]
      srcs += [src] if game.qualifies?(qualifier, src, King)
    end
    srcs[1] if srcs.length == 2
  end

  def self.legal_moves(src, game)
    normal_legal_moves(src, game) + legal_castles(src, game)
  end

  def self.normal_legal_moves(src, game)
    moves = [[-1, 0], [-1, 1], [0, 1], [1, 1],
             [1, 0], [1, -1], [0, -1], [-1, -1]]
    dsts = []
    moves.each do |move|
      dst = [move[0] + src[0], move[1] + src[1]]
      next unless game.board.valid_coords?(dst)

      if game.enemy?(dst)
        dsts << "K#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(dst[1] + 'a'.ord).chr}#{8 - dst[0]}"
      elsif game.board.empty?(dst)
        dsts << "K#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(dst[1] + 'a'.ord).chr}#{8 - dst[0]}"
      end
    end
    dsts
  end

  def self.legal_castles(src, game)
    result = []
    return result if game.board.info_at(src, :moven?)

    row = game.current_player == 'white' ? 7 : 0
    result << 'O-O' if game.board.info_at([row, 7],
                                          :moven?).nil? && game.board.board[row][5..6].map(&:piece) == [nil, nil]
    result << 'O-O-O' if game.board.info_at([row, 0],
                                            :moven?).nil? && game.board.board[row][1..3].map(&:piece) == [nil, nil, nil]
    result
  end
end
