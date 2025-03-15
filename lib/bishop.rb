# frozen_string_literal: true

require_relative 'piece'

# Bishop
class Bishop < Piece
  def initialize(black: false)
    super(black ? '♝' : '♗', 'B', black: black)
  end

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end

  def self.source(dst, game)
    uniq = [nil, source_ne(dst, game),
            source_se(dst, game),
            source_sw(dst, game),
            source_nw(dst, game)].uniq
    uniq[1] if uniq.length == 2
  end

  class << self
    private

    def source_ne(dst, game)
      (1..7).each do |offset|
        coords = [dst[0] - offset, dst[1] + offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.friend?(coords) && game.board.bishop?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_se(dst, game)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] + offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.friend?(coords) && game.board.bishop?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_sw(dst, game)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.friend?(coords) && game.board.bishop?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_nw(dst, game)
      (0..7).each do |offset|
        coords = [dst[0] - offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.friend?(coords) && game.board.bishop?(coords)
        return nil unless game.board.empty?(coords)
      end
      nil
    end
  end
end
