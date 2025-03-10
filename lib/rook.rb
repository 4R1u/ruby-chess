# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  def initialize(black: false)
    super(black ? '♜' : '♖', 'R', black: black)
  end

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end

  def self.source(dst, game)
    uniq = [nil, source_up(dst, game),
            source_down(dst, game),
            source_right(dst, game),
            source_left(dst, game)].uniq
    uniq[1] if uniq.length == 2
  end

  class << self
    private

    def source_left(dst, game)
      ((dst[1] + 1)..7).each do |col|
        coords = [dst[0], col]
        return coords if game.friend?(coords) && game.board.rook?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_right(dst, game)
      (0..(dst[1] - 1)).reverse_each do |col|
        coords = [dst[0], col]
        return coords if game.friend?(coords) && game.board.rook?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_down(dst, game)
      ((dst[0] + 1)..7).each do |row|
        coords = [row, dst[1]]
        return coords if game.friend?(coords) && game.board.rook?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_up(dst, game)
      (0..(dst[0] - 1)).reverse_each do |row|
        coords = [row, dst[1]]
        return coords if game.friend?(coords) && game.board.rook?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end
  end
end
