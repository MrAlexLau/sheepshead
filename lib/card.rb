class Card
  attr_accessor :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{value}#{suit}"
  end

  # returns the "suit" as considered when leading a trick
  # distinguishes between trump and the card's suit itself
  # for example, the queen of spades has the suit spade,
  # but is considered trump when leading a trick
  def leading_suit
    self.trump? ? 'T' : self.suit
  end

  def trump?
    # all queens, jacks, and diamonds are trump
    ['Q', 'J'].include?(@value) || self.suit == 'D'
  end
end