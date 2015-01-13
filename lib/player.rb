class Player
  include PlayerInput

  attr_accessor :name, :hand, :seat_number, :interactive, :tricks_won
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

  def wants_to_pick?
    # TODO: add logic for AI picking
    if self.interactive?
      user_picked = user_picks?(self.hand)
      puts "User picked: #{user_picked}"
      return user_picked
    else
      puts "#{self} passes"
      return false
    end
  end

  def bury!(blind_count)
    hand_before_burying = self.hand.clone
    if self.interactive?
      self.hand = user_bury_prompt(self.hand, blind_count)
    else
      # TODO: add logic for AI burying
      self.hand = hand_before_burying
      false
    end

    # the new blind is the cards buried
    (hand_before_burying - self.hand)
  end

  private

  def auto_pick_next_card(cards_played)
    # puts "Player's hand: #{self.hand.map { |card| card.value + card.suit }}"
    hand.each do |card|
      if RuleMaster.valid_card?(hand, card, cards_played)
        hand.delete(card)
        return card
      end
    end
  end

end
