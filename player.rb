class Player
  attr_accessor :name, :hand, :seat_number, :interactive
  alias_method :interactive?, :interactive

  def initialize
    @hand = []
  end

  def play_card(cards_played)
    puts "Cards played this trick: #{cards_played.join(', ')}"
    if interactive?
      puts "Here is your hand: #{hand.join(', ')}"
      puts "What card would you like to play?"
    end

    hand.first
  end

  private

  def valid_card?(card, cards_played)
    true
  end
end
