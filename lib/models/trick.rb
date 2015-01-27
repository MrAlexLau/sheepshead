class Trick
  attr_accessor :cards_played, :starting_seat

  def initialize
    @cards_played = []
  end

  def play(table)
    next_seat = self.starting_seat

    (table.players.count).times do
      player = table.player_at_seat(next_seat)

      if !@cards_played.empty?
        puts "Cards played this trick: #{@cards_played.join(', ')}"
      else
        if player.name == 'You'
          puts "You lead the trick."
        else
          puts "#{player} leads the trick."
        end
      end

      @cards_played << player.play_card(@cards_played)

      next_seat += 1
      next_seat = table.adjusted_seat_number(next_seat)
    end
  end

  def winner(table)
    spaces_from_starting_seat = @cards_played.index(winning_card)
    seat_number = table.adjusted_seat_number(self.starting_seat + spaces_from_starting_seat)
    table.player_at_seat(seat_number)
  end

  def winning_card
    if trump_present?(@cards_played)
      highest_trump_card(@cards_played)
    else
      highest_nontrump_card(@cards_played)
    end
  end

  def trump_present?(cards)
    !!cards.find { |card| card.trump? }
  end

  def highest_trump_card(cards)
    highest = cards.inject(cards.first) do |leader, current_card|
      current_card.trump_value > leader.trump_value ? current_card : leader
    end

    highest
  end

  def highest_nontrump_card(cards)
    suit_lead = cards.first.leading_suit
    highest = cards.inject(cards.first) do |leader, current_card|
      (current_card.nontrump_value > leader.nontrump_value && current_card.suit == suit_lead) ? current_card : leader
    end

    highest
  end

  def points
    @cards_played.inject(0) { |sum, card| sum + card.points }
  end
end
