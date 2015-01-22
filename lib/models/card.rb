class Card
  attr_accessor :value, :suit

  SUITS = {
    clubs: 'C',
    spades: 'S',
    hearts: 'H',
    diamonds: 'D'
  }

  TRUMP_SUIT = 'T'

  VALUES = ['7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  # ranked from lowest to highest
  # based on the value and suit of the card
  TRUMP_RANKINGS = [
    "7D",
    "8D",
    "9D",
    "KD",
    "10D",
    "AD",
    "JD",
    "JH",
    "JS",
    "JC",
    "QD",
    "QH",
    "QS",
    "QC"
  ]

  # ranked from lowest to highest
  # based on the value of the card
  NONTRUMP_RANKINGS = [
    "7",
    "8",
    "9",
    "K",
    "10",
    "A"
  ]

  # ranked from lowest to highest
  # based on the value of the card
  CARD_POINTS = {
    "J" => 2,
    "Q" => 3,
    "K" => 4,
    "10" => 10,
    "A" => 11
  }

  PARTNER_CARD = 'JD'

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
    self.trump? ? TRUMP_SUIT : self.suit
  end

  def trump?
    # all queens, jacks, and diamonds are trump
    ['Q', 'J'].include?(@value) || self.suit == 'D'
  end

  def trump_value
    return -1 if !trump?

    TRUMP_RANKINGS.index(self.to_s)
  end

  def nontrump_value
    NONTRUMP_RANKINGS.index(self.value)
  end

  def points
    CARD_POINTS[self.value] || 0
  end
end
