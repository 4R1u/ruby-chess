# frozen_string_literal: true

require_relative 'piece'

# Queen
class Queen < Piece
  def initialize(black: false)
    super(black ? '♛' : '♕', 'Q')
  end
end
