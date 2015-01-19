# This program simulates the game sheepshead

$LOAD_PATH << '.'
require 'lib/io/user_input.rb'
require 'lib/io/options_input.rb'
require 'lib/options.rb'
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


options = Options.new

puts options
puts "Do you want to keep these options? #{yes_instructions}"

if !agrees?(user_response_uppercase)
  # user has not agreed, prompt to update about new options
  options.number_of_players = number_of_players_prompt
  options.points_to_win = points_to_win_prompt
end

dealer_seat = rand(1..options.number_of_players)

continue = true
while continue
  game = Game.new(options, dealer_seat)
  game.start_game

  puts "Do you want to play another game?"
  continue = (gets.strip.upcase == 'Y')
end

puts "Game over."
