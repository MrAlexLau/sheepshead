class Table # as in, table of players
  attr_accessor :players

  def initialize(num_players)
    @players = (1..num_players).to_a.map do |num|
      player = Player.new
      player.name = "Player #{num}"
      player.seat_number = num
      player
    end

    @players.sample.interactive = true # sets one of the players to interactive mode

    puts "You are player #{@players.find { |player| player.interactive == true }.seat_number}"
  end

  def player_at_seat(seat_number)
    @players.find { |player| player.seat_number == seat_number }
  end

  # takes rollarounds into effect
  # aka if you go past the bounds in either direction
  # this is always relative to the first seat
  def adjusted_seat_number(seat_number)
    if (1..self.players.count).include?(seat_number)
      _seat = seat_number
    elsif (seat_number > self.players.count)
      # example: if the seat number is 7, but there are only 5 players
      # then the seat number is really 2
      _seat = seat_number % self.players.count
    elsif seat_number == 0
      # example: if the seat number is 0 and there are 5 players
      # this happens when the game calls for going "back" from the first seat
      # so roll around to the last seat, which is 5 in this example
      _seat = self.players.count
    else
      raise 'Invalid seat number!'
    end

    _seat
  end
end
