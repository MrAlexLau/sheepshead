#!/usr/bin/env rake

task :console do
  require 'irb'

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

  ARGV.clear
  IRB.start
end
