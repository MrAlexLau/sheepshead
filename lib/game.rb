class Game

  def initialize(dealer_seat)
    @dealer = Dealer.new(dealer_seat)
    @table = Table.new
    @tricks_played = 0
  end

  def start_game
    @dealer.deal(@table.players)
    @picker = @dealer.blind_selection(@table)
    @table.players.each { |player| player.check_for_partner! }

    # start with the person to the left of the dealer
    leaders_seat = @table.adjusted_seat_number(@dealer.seat_number + 1)

    if self.leaster?
      puts "----------------------"
      puts "Leaster!"
    end

    while !game_over?
      puts "----------------------"

      trick = Trick.new(@table, leaders_seat)
      trick.play(@table.players.count)
      @tricks_played += 1

      leaders_seat = trick.winner.seat_number
      trick.winner.take_trick(trick)
      puts "Cards played this trick: #{trick.cards_played.join(', ')}"
      puts "This trick was worth #{trick.points} points."
      puts "Trick Winner: #{trick.winner} with #{trick.winning_card}"
      puts "----------------------"
    end

    display_game_results
  end

  def display_game_results
    @table.teams.each do |team, players|
      _points = players.inject(0) { |sum, player| sum + player.points }
      players_names = players.map { |player| player.name }.join(", ")
      puts "#{team} (#{players_names}): #{_points} points"
    end
  end

  def game_over?
    @tricks_played >= 6 # needs to be updated for when the game isn't 5 handed
  end

  def leaster?
    !@picker
  end

  # debugging
  def game_status
    puts 'Here are the hands for each player:'
    @table.players.each do |player|
      puts player.name
      puts player.hand
      puts "is picker: #{player.is_picker}"
      puts "is partner: #{player.is_partner}"
    end

    puts "blind: #{@dealer.blind}"
  end
end
