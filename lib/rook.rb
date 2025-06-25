# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  def initialize(black: false)
    super(black ? '♜' : '♖', 'R', black: black)
  end

  def self.source(dst, str, game, type = self)
    qualifier = find_qualifier(str)
    uniq = [nil, source_up(dst, game, qualifier, type),
            source_down(dst, game, qualifier, type),
            source_right(dst, game, qualifier, type),
            source_left(dst, game, qualifier, type)].uniq
    uniq[1] if uniq.length == 2
  end

  def self.legal_moves(src, game)
    legal_moves_up(src, game) +
      legal_moves_right(src, game) +
      legal_moves_down(src, game) +
      legal_moves_left(src, game)
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

  def self.legal_moves_up(src, game)
    result = []
    (1..7).each do |i|
      if !game.board.valid_coords?([src[0] - i, src[1]])
        break
      elsif game.board.empty?([src[0] - i, src[1]])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] + 'a'.ord).chr}#{8 - src[0] + i}"
      elsif game.enemy?([src[0] - i, src[1]])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] + 'a'.ord).chr}#{8 - src[0] + i}"
        break
      end
    end
    result
  end

  def self.legal_moves_right(src, game)
    result = []
    (1..7).each do |i|
      if !game.board.valid_coords?([src[0], src[1] + i])
        break
      elsif game.board.empty?([src[0], src[1] + i])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] + i + 'a'.ord).chr}#{8 - src[0]}"
      elsif game.enemy?([src[0], src[1] + i])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] + i + 'a'.ord).chr}#{8 - src[0]}"
        break
      end
    end
    result
  end

  def self.legal_moves_down(src, game)
    result = []
    (1..7).each do |i|
      if !game.board.valid_coords?([src[0] + i, src[1]])
        break
      elsif game.board.empty?([src[0] + i, src[1]])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] + 'a'.ord).chr}#{8 - src[0] - i}"
      elsif game.enemy?([src[0] + i, src[1]])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] + 'a'.ord).chr}#{8 - src[0] - i}"
        break
      end
    end
    result
  end

  def self.legal_moves_left(src, game)
    result = []
    (1..7).each do |i|
      if !game.board.valid_coords?([src[0], src[1] - i])
        break
      elsif game.board.empty?([src[0], src[1] - i])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] - i + 'a'.ord).chr}#{8 - src[0]}"
      elsif game.enemy?([src[0], src[1] - i])
        result << "R#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] - i + 'a'.ord).chr}#{8 - src[0]}"
        break
      end
    end
    result
  end
end
