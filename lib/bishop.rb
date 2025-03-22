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

  def self.source(dst, str, game, type = self)
    qualifier = find_qualifier(str)
    uniq = [nil, source_ne(dst, game, qualifier, type),
            source_se(dst, game, qualifier, type),
            source_sw(dst, game, qualifier, type),
            source_nw(dst, game, qualifier, type)].uniq
    uniq[1] if uniq.length == 2
  end

  def self.source_ne(dst, game, qualifier, type)
    (1..7).each do |offset|
      coords = [dst[0] - offset, dst[1] + offset]
      return nil unless game.board.valid_coords?(coords)
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_se(dst, game, qualifier, type)
    (1..7).each do |offset|
      coords = [dst[0] + offset, dst[1] + offset]
      return nil unless game.board.valid_coords?(coords)
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_sw(dst, game, qualifier, type)
    (1..7).each do |offset|
      coords = [dst[0] + offset, dst[1] - offset]
      return nil unless game.board.valid_coords?(coords)
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_nw(dst, game, qualifier, type)
    (0..7).each do |offset|
      coords = [dst[0] - offset, dst[1] - offset]
      return nil unless game.board.valid_coords?(coords)
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end
end
