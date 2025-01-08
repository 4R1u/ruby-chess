# frozen_string_literal: true

require_relative 'piece'

# King
class King < Piece
  attr_accessor :moven

  def initialize(black: false)
    super(black ? '♚' : '♔', 'K')
    @moven = false
  end
end
