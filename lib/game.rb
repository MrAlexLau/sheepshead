class Game
  attr_reader :dealer, :table

  def initialize
    @dealer = Dealer.new
    @table = Table.new
  end

  def start_game(starting_seat)
    dealer.deal(table.players)
    game_status
    @tricks_played = 0
    leaders_seat = starting_seat

    while !game_over?
      puts "----------------------"

      trick = Trick.new(table, leaders_seat)
      trick.play(table.players.count)
      @tricks_played += 1

      leaders_seat = trick.winner.seat_number
      trick.winner.tricks_won = trick
      puts "Cards played this trick: #{trick.cards_played.join(', ')}"
      puts "This trick was worth #{trick.points} points."
      puts "Trick Winner: #{trick.winner} with #{trick.winning_card}"
      puts "----------------------"
    end
  end

  def game_over?
    @tricks_played >= 6 # needs to be updated for when the game isn't 5 handed
  end

  # debugging
  def game_status
    # puts 'Here are the hands for each player:'
    # table.players.each { |p| puts p.hand; puts "-----" }

    # puts "blind: #{dealer.blind}"
  end
end