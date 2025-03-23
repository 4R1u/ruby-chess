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
end
