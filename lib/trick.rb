class Trick
  attr_accessor :cards_played

  def initialize(table, starting_seat)
    @table = table
    @next_seat = @starting_seat = starting_seat
    @cards_played = []
  end

  def play(num_players)
    (num_players).times do
      player = @table.player_at_seat(@next_seat)

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

      @next_seat += 1

      # roll around to the first seat if the seat number is more than the number of players
      @next_seat = 1 if @next_seat > num_players
    end
  end

  def winner
    spaces_from_starting_seat = @cards_played.index(winning_card)

    # example if the starting_seat is 5
    # and spaces_from_starting_seat is 2
    # we want the second seat
    # so we have (5 + 2) mod 5
    final_seat = @starting_seat + spaces_from_starting_seat
    final_seat = final_seat % @table.players.count if final_seat > @table.players.count

    @table.player_at_seat(final_seat)
  end

  def winning_card
    if trump_present?(@cards_played)
      highest_trump_card(@cards_played)
    else
      highest_nontrump_card(@cards_played)
    end
  end

  def trump_present?(cards)
    cards.find { |card| card.trump? }
  end

  def highest_trump_card(cards)
    highest = cards.inject(cards.first) do |leader, current_card|
      current_card.trump_value > leader.trump_value ? current_card : leader
    end

    highest
  end

  def highest_nontrump_card(cards)
    suit_lead = cards_played.first.leading_suit
    highest = cards.inject(cards.first) do |leader, current_card|
      (leader.nontrump_value > current_card.nontrump_value && leader.suit == suit_lead) ? leader : current_card
    end

    highest
  end

  def points
    @cards_played.inject(0) { |sum, card| sum + card.points }
  end
end
