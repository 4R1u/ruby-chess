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

  def self.source(dst, str, game, type = Rook)
    qualifier = find_qualifier(str)
    uniq = [nil, source_up(dst, game, qualifier, type),
            source_down(dst, game, qualifier, type),
            source_right(dst, game, qualifier, type),
            source_left(dst, game, qualifier, type)].uniq
    uniq[1] if uniq.length == 2
  end

  def self.source_left(dst, game, qualifier, type)
    ((dst[1] + 1)..7).each do |col|
      coords = [dst[0], col]
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_right(dst, game, qualifier, type)
    (0..(dst[1] - 1)).reverse_each do |col|
      coords = [dst[0], col]
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_down(dst, game, qualifier, type)
    ((dst[0] + 1)..7).each do |row|
      coords = [row, dst[1]]
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end

  def self.source_up(dst, game, qualifier, type)
    (0..(dst[0] - 1)).reverse_each do |row|
      coords = [row, dst[1]]
      return coords if game.qualifies?(qualifier, coords, type)
      return nil unless game.board.empty?(coords)
    end
    nil
  end
end
