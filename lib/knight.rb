# frozen_string_literal: true

require_relative 'piece'

# Knight
class Knight < Piece
  def initialize(black: false)
    super(black ? '♞' : '♘', 'N', black: black)
  end

  def self.source(dst, str, game)
    qualifier = find_qualifier(str)
    moves = [[1, 2], [2, 1], [2, -1], [1, -2],
             [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    srcs = [nil]
    moves.each do |move|
      src = [move[0] + dst[0], move[1] + dst[1]]
      srcs += [src] if game.qualifies?(qualifier, src, Knight)
    end
    srcs[1] if srcs.length == 2
  end

  def self.legal_moves(src, game)
    moves = [[-2, 1], [-1, 2], [1, 2], [2, 1],
             [2, -1], [1, -2], [-1, -2], [-2, -1]]
    dsts = []
    moves.each do |move|
      dst = [move[0] + src[0], move[1] + src[1]]
      if game.enemy?(dst)
        dsts << "N#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(dst[1] + 'a'.ord).chr}#{8 - dst[0]}"
      elsif game.board.empty?(dst)
        dsts << "N#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(dst[1] + 'a'.ord).chr}#{8 - dst[0]}"
      end
    end
    dsts
  end
end
