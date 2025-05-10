# frozen_string_literal: true

require_relative 'piece'

# Pawn
class Pawn < Piece
  def initialize(black: false)
    super(black ? '♟' : '♙', '', black: black)
  end

  def self.destination(str, game)
    gstr = str.sub(' e.p.', '')
    gstr = gstr.sub('+', '') if gstr[-1] == '+'
    dst = [8 - gstr[-1].to_i, gstr[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) && !game.friend?(dst)
  end

  def self.source(dst, str, game)
    src = find_source(dst, str, game)
    src if src && game.qualifies?(find_qualifier(str), src, Pawn)
  end

  def self.find_source(dst, str, game)
    if str.length > 2
      file_number = str[0].ord - 'a'.ord
      en_passant_source(dst, file_number, game) ||
        (capturing_pawn(dst, file_number, game) unless str.include?(' e.p.'))
    elsif game.board.empty?(dst)
      source_one_square_behind(dst, game) ||
        source_two_squares_behind(dst, game)
    end
  end

  class << self
    private

    def source_one_square_behind(dst, game)
      src = [dst[0] + game.backwards, dst[1]]
      src if game.board.pawn?(src) && game.friend?(src)
    end

    def source_two_squares_behind(dst, game)
      src = [dst[0] + (2 * game.backwards), dst[1]]

      src if game.board.pawn?(src) && !game.board.info_at(src, :moven?) &&
             game.friend?(src) && game.board.empty?([src[0] + game.forwards, src[1]])
    end

    def capturing_pawn(dst, file_number, game)
      return unless (0..7).cover?(file_number)

      src = [dst[0] + game.backwards, file_number]
      src if game.board.pawn?(src) && game.friend?(src) &&
             (dst[1] - file_number).abs == 1 &&
             game.enemy?(dst)
    end

    def en_passant_source(dst, file_number, game)
      src = [dst[0] + game.backwards, file_number]
      removed = [src[0], dst[1]]

      return unless game.board.valid_coords?(src) &&
                    game.board.valid_coords?(dst) && game.enemy?(removed)

      if game.board.pawn?(src) && game.friend?(src) &&
         (dst[1] - src[1]).abs == 1
        game.board.remove_piece(removed)
        src
      end
    end
  end
end
