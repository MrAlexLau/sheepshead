# This program simulates the game sheepshead

$LOAD_PATH << '.'
require 'lib/dealer.rb'
require 'lib/card.rb'
require 'lib/deck.rb'
require 'lib/rule_master.rb'
require 'lib/player_input.rb'
require 'lib/player.rb'
require 'lib/game.rb'
require 'lib/trick.rb'
require 'lib/table.rb'

require 'braise'
require 'ostruct'


options = OpenStruct.new(
  number_of_players: 5,
  points_to_win: 50
)

dealer_seat = rand(1..options.number_of_players)


continue = true
while continue
  game = Game.new(options, dealer_seat)
  game.start_game

  puts "Do you want to play another game?"
  continue = (gets.strip.upcase == 'Y')
end

puts "Game over."
