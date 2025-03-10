# frozen_string_literal: true

require_relative 'piece'

# Knight
class Knight < Piece
  def initialize(black: false)
    super(black ? '♞' : '♘', 'N', black: black)
  end

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end

  def self.find_source(dst, game)
    moves = [[1, 2], [2, 1], [2, -1], [1, -2],
             [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    srcs = [nil]
    moves.each do |move|
      src = [move[0] + dst[0], move[1] + dst[1]]
      srcs += [src] if game.board.valid_coords?(src) &&
                       game.board.knight?(src) && game.friend?(src)
    end
    srcs[1] if srcs.length == 2
  end
end
