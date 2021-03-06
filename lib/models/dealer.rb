class Dealer
  attr_accessor :deck, :seat_number

  def initialize(dealer_seat, number_of_players)
    @deck = Deck.new(number_of_players)
    @seat_number = dealer_seat
  end

  # deals the entire deck to the players
  def deal(table)
    num_players = table.players.count
    deck.shuffle
    deck.deal_blind

    player_index = 0
    seat = table.adjusted_seat_number(self.seat_number + 1) # start with the player to the left of the dealer

    while deck.cards.any?
      deal_player(table.player_at_seat(seat))
      seat = table.adjusted_seat_number(seat + 1)
    end

    table.players.each { |player| player.check_for_partner! } if table.players.count == 5
  end

  def blind
    deck.blind
  end

  def deal_player(player)
    player.hand << deck.pull_top_card!
  end

  # starting with the player to the left of the dealer
  # see if anyone wants to pick up the blind
  # returns the picker if he exists, nil otherwise
  def blind_selection(table)
    seat = table.adjusted_seat_number(self.seat_number + 1) # start with the player to the left of the dealer
    table.players.count.times do
      player = table.player_at_seat(seat)

      if player.wants_to_pick?
        player.is_picker = true
        player.hand = player.hand + blind
        player.check_for_partner! if table.players.count == 5
        @blind = player.bury!(blind.count)

        puts "The blind is #{@blind}"
        return player
      end

      seat = table.adjusted_seat_number(seat + 1)
    end

    nil # nobody picked
  end
end
