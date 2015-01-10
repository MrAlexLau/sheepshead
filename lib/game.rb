class Game
  attr_reader :dealer, :table

  def initialize
    @dealer = Dealer.new
    @table = Table.new
  end

  def start_game
    dealer.deal(table.players)
    game_status
    @tricks_played = 0

    while !game_over?
      @trick = Trick.new(table, 1)
      @trick.play(table.players.count)
      @tricks_played += 1
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