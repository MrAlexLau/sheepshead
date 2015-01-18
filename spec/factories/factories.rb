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
  end

  factory :trick do
    initialize_with { Trick.new(Table.new, 1) }
  end

  factory :table do

    factory :table_with_5_players do
      after(:build) do |table|
        5.times do
          table.players << build(:player)
        end
      end
    end
  end
end
