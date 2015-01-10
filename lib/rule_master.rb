class RuleMaster
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

  def self.must_follow_suit?(hand, suit_lead)
    hand.find { |card| card.leading_suit == suit_lead }
  end
end
