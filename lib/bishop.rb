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

  def self.source(dst, str, game)
    qualifier = find_qualifier(str)
    uniq = [nil, source_ne(dst, game, qualifier),
            source_se(dst, game, qualifier),
            source_sw(dst, game, qualifier),
            source_nw(dst, game, qualifier)].uniq
    uniq[1] if uniq.length == 2
  end

  class << self
    private

    def source_ne(dst, game, qualifier)
      (1..7).each do |offset|
        coords = [dst[0] - offset, dst[1] + offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, Bishop)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_se(dst, game, qualifier)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] + offset]
        return coords if game.qualifies?(qualifier, coords, Bishop)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_sw(dst, game, qualifier)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, Bishop)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_nw(dst, game, qualifier)
      (0..7).each do |offset|
        coords = [dst[0] - offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, Bishop)
        return nil unless game.board.empty?(coords)
      end
      nil
    end
  end
end
