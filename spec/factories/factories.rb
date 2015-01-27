FactoryGirl.define do
  factory :card do
    value "J"
    suit "D"

    initialize_with { Card.new(value, suit) }
  end

  factory :player do
    sequence :name do |n|
      "Player #{n}"
    end

    factory :player_with_hand do
      after(:build) do |player|
        player.hand = []
        player.hand << build(:card)
      end
    end

    factory :player_with_tricks_won do
      after(:build) do |player|
        player.tricks_won = []
        player.tricks_won << build(:trick)
      end
    end

    factory :interactive_player do
      interactive true
    end

    factory :leaster_winner do
      after(:build) do |player|
        player.hand = []
        trick = build(:trick)
        trick.cards_played = [build(:card, value: 'K', suit: 'D')]
        player.tricks_won = [trick]
      end
    end

    factory :leaster_loser do
      after(:build) do |player|
        trick = build(:trick)
        trick.cards_played = [build(:card, value: '10', suit: 'D')]
        player.tricks_won = [trick]
      end
    end

    factory :leaster_no_trick do
      after(:build) do |player|
        player.tricks_won = []
      end
    end
  end

  factory :trick do
    starting_seat 1
  end

  factory :table do
    factory :table_with_3_players do
      initialize_with { Table.new(3) }
    end

    initialize_with { Table.new(5) }
  end
end
