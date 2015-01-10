class Trick
  attr_accessor :cards_played

  def initialize(table, starting_seat)
    @table = table
    @next_seat = starting_seat
    @cards_played = []
  end

  def play(num_players)
    (num_players - 1).times do
      player = @table.player_at_seat(@next_seat)
      @cards_played << player.play_card(@cards_played)
      @next_seat += 1
      puts "Cards played this trick: #{@cards_played.join(', ')}"
    end

    puts "--------"
  end
end
