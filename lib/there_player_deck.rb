class ThreePlayerDeck < Deck
  def initialize
    super.initialize

    # 3 player deck doesn't use black sevens, remove them
    seven_clubs = @cards.find { |card| card.value == '7' && card.suit == Card::SUITS[:clubs] }
    @cards.delete(seven_clubs)

    seven_spades = @cards.find { |card| card.value == '7' && card.suit == Card::SUITS[:spades] }
    @cards.delete(seven_spades)
  end

  def blind_reached?
    (cards.count <= 4)
  end
end