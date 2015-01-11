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

g = Game.new

starting_seat = 1 # TODO: change this to vary from game to game
g.start_game(starting_seat)
