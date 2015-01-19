def number_of_players_prompt
  puts "How many players do you want?"
  response = gets.to_i
  while !(3..5).include?(response)
    puts "Must be between 3 and 5 players"
    response = gets.to_i
  end

  response
end

def points_to_win_prompt
  puts "How many points to win?"
  response = gets.to_i
  while !(10..150).include?(response)
    puts "Must be between 10 and 150 points"
    response = gets.to_i
  end

  response
end
