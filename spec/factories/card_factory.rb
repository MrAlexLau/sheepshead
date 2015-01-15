# This will guess the User class
FactoryGirl.define do
  factory :card do
    value "K"
    suit "D"
  end

  initialize_with { Card.new(value, suit) }
end
