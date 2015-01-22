require 'rubygems'
require 'factory_girl'

ENV["RAILS_ENV"] ||= 'test'

$LOAD_PATH << '.'

Dir["lib/*.rb"].each { |f| require f }
Dir["lib/io/*.rb"].each { |f| require f }
Dir["lib/models/*.rb"].each { |f| require f }
Dir["lib/services/*.rb"].each { |f| require f }

Dir["spec/factories/*.rb"].each { |f| require f }
Dir["spec/support/*.rb"].each { |f| require f }
# Dir[Rails.root.join("spec/**/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # Includes
  config.include FactoryGirl::Syntax::Methods
end
