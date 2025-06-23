# frozen_string_literal: true

require_relative 'piece'

# Pawn
class Pawn < Piece
  def initialize(black: false)
    super(black ? '♟' : '♙', '', black: black)
  end

  def self.destination(str, game)
    i = str.size - 1
    i -= 1 until ('1'..'8').cover?(str[i]) || i.zero?

    return if i.zero?

    find_destination(str, game, i)
  end

  def self.source(dst, str, game)
    return if dst.nil?

    x = str.size - 1
    x -= 1 until str[x] == 'x' || x.zero?
    result = if x.zero?
               non_capturing_source(dst, game) || capturing_source(dst, str, game)
             else
               capturing_source(dst, str, game)
             end
    return unless result

    result if valid_promotion?(result, dst, str, game)
  end

  class << self
    private

    def find_destination(str, game, index)
      dst = [8 - str[index].to_i, str[index - 1].ord - 'a'.ord]
      dst if game.board.valid_coords?(dst) && !game.friend?(dst)
    end

    def capturing_source(dst, str, game)
      return ep_source(dst, str, game) if str[-5..] == ' e.p.'

      non_ep_cap_source(dst, str, game) ||
        ep_source(dst, str, game)
    end

    def ep_source(dst, str, game)
      board = game.board
      src = [dst[0] - game.forwards, str[0].ord - 'a'.ord]
      removed = [dst[0] - game.forwards, dst[1]]
      return unless game.board.valid_coords?(src) &&
                    game.board.valid_coords?(dst) &&
                    (src[1] - dst[1]).abs == 1 &&
                    game.friend?(src) && board.pawn?(src) &&
                    board.pawn?(removed) && game.enemy?(removed) &&
                    board.info_at(removed, :moven?) == game.moves.length - 1

      board.remove_piece(removed)
      src
    end

    def non_ep_cap_source(dst, str, game)
      src = [dst[0] - game.forwards, str[0].ord - 'a'.ord]
      src if game.board.valid_coords?(src) && (src[1] - dst[1]).abs == 1 && game.friend?(src) &&
             game.board.pawn?(src) && game.enemy?(dst)
    end

    def non_capturing_source(dst, game)
      return unless game.board.valid_coords?(dst) && game.board.empty?(dst)

      src = [dst[0] - game.forwards, dst[1]]
      return src if game.board.valid_coords?(src) &&
                    game.friend?(src) && game.board.empty?(dst) &&
                    game.board.pawn?(src)
      return unless game.board.empty?(src)

      non_capturing_source_two_squares_behind(src, game)
    end

    def non_capturing_source_two_squares_behind(src, game)
      src[0] -= game.forwards
      src if game.board.valid_coords?(src) &&
             game.friend?(src) && !game.board.info_at(src, :moven?) &&
             game.board.pawn?(src)
    end

    def valid_promotion?(src, dst, str, game)
      # true and false return values indicate whether the move is allowed or not
      piececlass = str.size - 1
      piececlass -= 1 until %w[K Q B N R].include?(str[piececlass]) ||
                            piececlass.zero?
      return false if piececlass.zero? && [0, 7].include?(dst[0])
      return true unless [0, 7].include?(dst[0])

      result = { K: King, Q: Queen, B: Bishop, N: Knight,
                 R: Rook }[str[piececlass].to_sym].new(black: game.board.board[src[0]][src[1]].piece.black)
      game.board.place_piece(src, result)
      true
    end
  end
end
