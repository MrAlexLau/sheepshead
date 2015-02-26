$LOAD_PATH << '.'

Dir["lib/*.rb"].each { |f| require f }
Dir["lib/io/*.rb"].each { |f| require f }
Dir["lib/models/*.rb"].each { |f| require f }
Dir["lib/services/*.rb"].each { |f| require f }

require 'braise'

Repete.hook

options = Options.new

puts options
puts "Do you want to keep these options? #{yes_instructions}"

if !agrees?(user_response_uppercase)
  # user has not agreed, prompt to update about new options
  options.number_of_players = number_of_players_prompt
  options.points_to_win = points_to_win_prompt
end

table = Table.new(options.number_of_players)
table.set_interactive_player
match = Match.new(table, options)
match.start

puts "Game over."
