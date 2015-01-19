module PlayerInput
  def next_card_prompt(hand)
    puts "Here is your hand:"
    hand.each_with_index do |card, i|
      puts "#{i + 1}: #{card}"
    end
  end

  # user = an interactive user from the terminal
  def card_from_user(hand, cards_played)
    next_card_prompt(hand)

    puts "What card would you like to play?"
    card = get_card_following_suit(hand, cards_played)

    puts "You picked #{card}"
    hand.delete(card)

    card
  end

  def get_valid_card_number(hand)
    card_number = gets.to_i
    number_in_range = (1..hand.count).include?(card_number)

    while !number_in_range
      puts "Card number must be between 1 and #{hand.count}"
      card_number = gets.to_i
      number_in_range = (1..hand.count).include?(card_number)
    end

    card_number
  end

  def get_card_following_suit(hand, cards_played)
    card_number = get_valid_card_number(hand)
    card = hand[card_number - 1]

    while !RuleMaster.valid_card?(hand, card, cards_played)
      puts "You must follow suit. #{leading_suit_pretty_name(cards_played)} was lead."
      puts "What card would you like to play?"
      card_number = get_valid_card_number(hand)
      card = hand[card_number - 1]
    end

    card
  end

  def leading_suit_pretty_name(cards_played)
    lead_suit = cards_played.first.leading_suit

    case lead_suit
    when 'T'
      'Trump'
    when 'S'
      'Spades'
    when 'C'
      'Clubs'
    when 'H'
      'Hearts'
    end
  end

  def user_picks?(hand)
    @user_picks ||= begin
      next_card_prompt(hand)
      puts "Would you like to pick? (Y for yes)"
      response = gets
      response.strip.upcase == 'Y'
    end
  end

  # prompts the user for which cards to bury
  # returns the hand after burying
  def user_bury_prompt(hand, blind_count)
    blind_count.times do
      next_card_prompt(hand)
      puts "Which card would you like to bury?"
      card_number = get_valid_card_number(hand)
      hand.delete_at(card_number - 1)
    end

    hand
  end
end
