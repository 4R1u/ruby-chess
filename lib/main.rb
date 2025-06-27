# frozen_string_literal: true

require_relative 'game'

g = Game.new

while g.able_to_move?
  g.board.output
  puts "#{g.current_player}: "
  g.move gets.chomp
  puts 'Check!' if g.check?
end

puts 'Game over!'
