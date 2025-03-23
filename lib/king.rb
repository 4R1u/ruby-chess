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
end
