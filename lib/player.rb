class Player
  attr_accessor :name, :hand, :seat_number, :interactive
  alias_method :interactive?, :interactive

  def initialize
    @hand = []
  end

  def play_card(cards_played)
    # if interactive?
    #   puts "Here is your hand: #{hand.join(', ')}"
    #   puts "What card would you like to play?"
    # end

    puts "Player's hand: #{self.hand.map { |card| card.value + card.suit }}"
    hand.each do |card|
      if valid_card?(card, cards_played)
        hand.delete(card)
        return card
      end
    end
  end

  private

  def valid_card?(card, cards_played)
    return true if cards_played.empty? # always valid when the player is leading the trick

    raise cards_played.inspect if cards_played.first.nil?

    suit_lead = cards_played.first.suit

    if must_follow_suit?(suit_lead)
      return (card.leading_suit == suit_lead)
    else
      # if the player doesn't have to follow suit
      # then any card is fine
      return true
    end
  end

  def must_follow_suit?(suit_lead)
    hand.find { |card| card.leading_suit == suit_lead }
  end
end
