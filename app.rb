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

num_players = 5 # TODO: make this configurable
dealer_seat = rand(1..num_players)

continue = true
while continue
  game = Game.new(dealer_seat)
  game.start_game

  puts "Do you want to play another game?"
  continue = (gets.strip.upcase == 'Y')
end

puts "Game over."
