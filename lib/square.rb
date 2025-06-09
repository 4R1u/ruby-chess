# frozen_string_literal: true

require_relative 'piece'

# A square on a chess board
class Square
  attr_reader :piece, :dark

  def initialize(piece, dark: false)
    @piece = piece.is_a?(Piece) ? piece : nil
    @dark = dark
  end

  def piece=(piece)
    @piece = piece.is_a?(Piece) || piece.nil? ? piece : @piece
  end

  def output
    if @dark
      print "\e[0;30;45m#{@piece.is_a?(Piece) ? @piece.char.encode('UTF-8') : ' '} \e[0m"
    else
      print "\e[0;30;47m#{@piece.is_a?(Piece) ? @piece.char.encode('UTF-8') : ' '} \e[0m"
    end
  end
end
