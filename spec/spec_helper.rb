require 'rubygems'
require 'factory_girl'

ENV["RAILS_ENV"] ||= 'test'

$LOAD_PATH << '.'

Dir["spec/factories/*.rb"].each { |f| require f }
Dir["spec/support/*.rb"].each { |f| require f }
# Dir[Rails.root.join("spec/**/support/**/*.rb")].each {|f| require f}

require 'lib/dealer.rb'
require 'lib/card.rb'
require 'lib/deck.rb'
require 'lib/rule_master.rb'
require 'lib/player_input.rb'
require 'lib/player.rb'
require 'lib/game.rb'
require 'lib/trick.rb'
require 'lib/table.rb'

RSpec.configure do |config|
  # Includes
  config.include FactoryGirl::Syntax::Methods
end
