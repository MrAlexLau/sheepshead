class Deck
  attr_accessor :cards

  def initialize(number_of_players)
    @cards = []
    @number_of_players = number_of_players
    load_cards
  end

  def shuffle
    cards.shuffle!
  end

  def blind_reached?
    (cards.count <= blind_count(@number_of_players))
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

  private

  def blind_count(num_players)
    case num_players
    when 3
      return 4
    when 4
      return 3
    when 5
      return 2
    else
      raise 'Invalid number of players!'
    end
  end

  def load_cards
    Card::VALUES.each do |value|
      Card::SUITS.values.each do |suit|
        @cards << Card.new(value, suit) unless should_be_skipped?(value, suit)
      end
    end
  end

  # only skip adding a card if the game is in 3 player mode
  # and the card is a black seven
  def should_be_skipped?(value, suit)
    return false unless @number_of_players == 3

    (value == '7' && suit == Card::SUITS[:clubs]) || (value == '7' && suit == Card::SUITS[:spades])
  end
end