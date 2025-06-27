# frozen_string_literal: true

require_relative 'piece'

# Bishop
class Bishop < Piece
  def initialize(black: false)
    super(black ? '♝' : '♗', 'B', black: black)
  end

  def self.source(dst, str, game, type = self)
    qualifier = find_qualifier(str)
    uniq = [nil, source_ne(dst, game, qualifier, type),
            source_se(dst, game, qualifier, type),
            source_sw(dst, game, qualifier, type),
            source_nw(dst, game, qualifier, type)].uniq
    uniq[1] if uniq.length == 2
  end

  def self.legal_moves(src, game, letter = 'B')
    legal_moves_ne(src, game, letter) +
      legal_moves_se(src, game, letter) +
      legal_moves_sw(src, game, letter) +
      legal_moves_nw(src, game, letter)
  end

  class << self
    private

    def source_ne(dst, game, qualifier, type)
      (1..7).each do |offset|
        coords = [dst[0] - offset, dst[1] + offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, type)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_se(dst, game, qualifier, type)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] + offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, type)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_sw(dst, game, qualifier, type)
      (1..7).each do |offset|
        coords = [dst[0] + offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, type)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def source_nw(dst, game, qualifier, type)
      (1..7).each do |offset|
        coords = [dst[0] - offset, dst[1] - offset]
        return nil unless game.board.valid_coords?(coords)
        return coords if game.qualifies?(qualifier, coords, type)
        return nil unless game.board.empty?(coords)
      end
      nil
    end

    def legal_moves_ne(src, game, letter)
      result = []
      (1..7).each do |i|
        if !game.board.valid_coords?([src[0] - i, src[1] + i])
          break
        elsif game.board.empty?([src[0] - i, src[1] + i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] + i + 'a'.ord).chr}#{8 - src[0] + i}"
        elsif game.enemy?([src[0] - i, src[1] + i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] + i + 'a'.ord).chr}#{8 - src[0] + i}"
          break
        end
      end
      result
    end

    def legal_moves_se(src, game, letter)
      result = []
      (1..7).each do |i|
        if !game.board.valid_coords?([src[0] + i, src[1] + i])
          break
        elsif game.board.empty?([src[0] + i, src[1] + i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] + i + 'a'.ord).chr}#{8 - src[0] - i}"
        elsif game.enemy?([src[0] + i, src[1] + i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] + i + 'a'.ord).chr}#{8 - src[0] - i}"
          break
        end
      end
      result
    end

    def legal_moves_sw(src, game, letter)
      result = []
      (1..7).each do |i|
        if !game.board.valid_coords?([src[0] + i, src[1] - i])
          break
        elsif game.board.empty?([src[0] + i, src[1] - i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] - i + 'a'.ord).chr}#{8 - src[0] - i}"
        elsif game.enemy?([src[0] + i, src[1] - i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] - i + 'a'.ord).chr}#{8 - src[0] - i}"
          break
        end
      end
      result
    end

    def legal_moves_nw(src, game, letter)
      result = []
      (1..7).each do |i|
        if !game.board.valid_coords?([src[0] - i, src[1] - i])
          break
        elsif game.board.empty?([src[0] - i, src[1] - i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}#{(src[1] - i + 'a'.ord).chr}#{8 - src[0] + i}"
        elsif game.enemy?([src[0] - i, src[1] - i])
          result << "#{letter}#{(src[1] + 'a'.ord).chr}#{8 - src[0]}x#{(src[1] - i + 'a'.ord).chr}#{8 - src[0] + i}"
          break
        end
      end
      result
    end
  end
end
