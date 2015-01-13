class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    values = ['7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    suits = ['C', 'S', 'H', 'D'] # clubs, spades, hearts, diamonds
    # suits = ['♧', '♡', '♤', '♢']

    values.each do |value|
      suits.each do |suit|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle
    cards.shuffle!
  end

  def blind_reached?
    (cards.count <= 2) # needs to be updated based on the number of players
  end

  # adding a bang since this modifies the deck
  def pull_top_card!
    cards.pop
  end

  def to_s
    cards.join(', ')
  end

  def blind
    cards
  end
end