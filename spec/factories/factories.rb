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

        5.times do
          player.hand << build(:card)
        end
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

    factory :single_trick_player do
      after(:build) do |player|
        trick = build(:trick)
        trick.cards_played = [build(:card, value: '10', suit: 'D')]
        player.tricks_won = [trick]
      end
    end

    factory :no_trick_player do
      after(:build) do |player|
        player.tricks_won = []
      end
    end
  end

  factory :trick do
    starting_seat 1

    factory :thirty_point_trick do
      after(:build) do |trick|
        3.times do
          trick.cards_played << build(:card, value: '10', suit: 'D')
        end
      end
    end

    factory :sixty_point_trick do
      after(:build) do |trick|
        6.times do
          trick.cards_played << build(:card, value: '10', suit: 'D')
        end
      end
    end

    factory :ninety_point_trick do
      after(:build) do |trick|
        9.times do
          trick.cards_played << build(:card, value: '10', suit: 'D')
        end
      end
    end

    factory :one_twenty_point_trick do
      after(:build) do |trick|
        12.times do
          trick.cards_played << build(:card, value: '10', suit: 'D')
        end
      end
    end
  end

  factory :table do
    factory :table_with_3_players do
      initialize_with { Table.new(3) }
    end

    initialize_with { Table.new(5) }
  end
end
