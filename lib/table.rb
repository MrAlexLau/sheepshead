class Table # as in, table of players
  attr_accessor :players

  def initialize
    @players = (1..5).to_a.map do |num| # TODO: adjust for different numbers of players
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
    _seat = seat_number
    if (_seat > self.players.count)
      # example: if the seat number is 7, but there are only 5 players
      # then the seat number is really 2
      _seat = seat_number % self.players.count
    elsif _seat == 0
      # example: if the seat number is 0 and there are 5 players
      # this happens when the game calls for going "back" from the first seat
      # so roll around to the last seat, which is 5 in this example
      _seat = self.players.count
    end

    _seat
  end

  def teams
    if @players.count == 5
      {
        'Picking Team' => @players.select { |player| player.is_picker? || player.is_partner? },
        'Other Team' => @players.select { |player| !player.is_picker? && !player.is_partner? }
      }
    end
  end
end
