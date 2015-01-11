class Player
  include PlayerInput

  attr_accessor :name, :hand, :seat_number, :interactive
  alias_method :interactive?, :interactive
  alias_method :to_s, :name

  def initialize
    @hand = []
  end

  def play_card(cards_played)
    interactive? ? card_from_user(hand, cards_played) : auto_pick_next_card(cards_played)
  end

  def name
    interactive? ? 'You' : @name
  end

  private

  def auto_pick_next_card(cards_played)
    puts "Player's hand: #{self.hand.map { |card| card.value + card.suit }}"
    hand.each do |card|
      if RuleMaster.valid_card?(hand, card, cards_played)
        hand.delete(card)
        return card
      end
    end
  end

end
