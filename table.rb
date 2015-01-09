class Table # as in, table of players
  attr_accessor :players


  def initialize
    @players = (1..5).to_a.map do |num|
      player = Player.new
      player.name = "Player #{num}"
      player.seat_number = 1
      player
    end

    # @players.sample.interactive?(true) # sets one of the players to interactive mode
  end

  def player_at_seat(seat_number)
    @players.find { |player| player.seat_number == seat_number }
  end

end