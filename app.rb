# This program simulates the game sheepshead

$LOAD_PATH << '.'

Dir["lib/*.rb"].each { |f| require f }
Dir["lib/io/*.rb"].each { |f| require f }
Dir["lib/models/*.rb"].each { |f| require f }


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

table = Table.new(options.number_of_players)

continue = true
while continue
  game = Game.new(options, table, dealer_seat)
  game.start_game

  puts "Do you want to play another game?"
  continue = agrees?(user_response_uppercase)
end

puts "Game over."
