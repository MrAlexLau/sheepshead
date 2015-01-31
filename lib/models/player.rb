class Player
  include PlayerInput

  attr_accessor :name, :hand, :seat_number, :interactive, :tricks_won, :is_partner, :is_picker, :blind
  alias_method :interactive?, :interactive
  alias_method :is_partner?, :is_partner
  alias_method :is_picker?, :is_picker
  alias_method :to_s, :name

  def initialize
    @hand = []
    @tricks_won = []
    @blind = []
  end

  # resets all game-related information
  def reset!
    self.hand = []
    self.tricks_won = []
    self.blind = []
    self.is_partner = false
    self.is_picker = false
  end

  def play_card(cards_played)
    interactive? ? card_from_user(hand, cards_played) : auto_pick_next_card(cards_played)
  end

  def name
    interactive? ? 'You' : @name
  end

  def wants_to_pick?
    if self.interactive?
      user_picked = user_picks?(self.hand)
      puts "User picked: #{user_picked}"
      return user_picked
    else
      puts "#{self} picks? #{ai_picks?}"
      return ai_picks?
    end
  end

  def ai_picks?
    trump_count = self.hand.inject(0) { |sum, card| card.trump? ? sum + 1 : sum }
    puts "trump_count: #{trump_count}"
    puts "hand: #{self.hand.map {|card| card.to_s}}"

    (trump_count > 3)
  end

  def bury!(blind_count)
    hand_before_burying = self.hand.clone
    if self.interactive?
      self.hand = user_bury_prompt(self.hand, blind_count)
    else
      # AI naively buries the first n cards for now
      blind_count.times do
        self.hand.delete_at(0)
      end
    end

    # the new blind is the cards buried
    @blind = (hand_before_burying - self.hand)
  end

  def check_for_partner!
    self.is_partner = !self.hand.find { |card| card.to_s == Card::PARTNER_CARD }.nil?
  end

  def points
    total = 0
    total += self.tricks_won.inject(0) { |sum, trick| sum + trick.points }
    total += blind.inject(0) { |sum, card| sum + card.points }

    total
  end

  def take_trick(trick)
    @tricks_won << trick
  end

  def self.valid_card?(hand, card, cards_played)
    return true if cards_played.empty? # always valid when the player is leading the trick

    suit_lead = cards_played.first.leading_suit

    if must_follow_suit?(hand, suit_lead)
      return (card.leading_suit == suit_lead)
    else
      # if the player doesn't have to follow suit
      # then any card is fine
      return true
    end
  end

  private

  def auto_pick_next_card(cards_played)
    # puts "Player's hand: #{self.hand.map { |card| card.value + card.suit }}"
    hand.each_with_index do |card, i|
      if Player.valid_card?(hand, card, cards_played)
        hand.delete_at(i)
        return card
      end
    end
  end

  def self.must_follow_suit?(hand, suit_lead)
    hand.find { |card| card.leading_suit == suit_lead }
  end
end
