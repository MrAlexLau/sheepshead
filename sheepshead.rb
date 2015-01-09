# This program simulates the game sheepshead

$LOAD_PATH << '.'
require 'dealer.rb'
require 'card.rb'
require 'deck.rb'
require 'player.rb'
require 'game.rb'
require 'trick.rb'
require 'table.rb'

g = Game.new

g.start_game