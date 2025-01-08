# frozen_string_literal: true

require_relative 'piece'

# Knight
class Knight < Piece
  def initialize(black: false)
    super(black ? '♞' : '♘', '')
  end
end
