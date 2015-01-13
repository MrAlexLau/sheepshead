# card_spec.rb
require 'card'

describe Card, "#initialize" do
  it "sets the suit" do
    card = Card.new('J', 'D')
    expect(card.suit).to eq('D')
  end

  it "sets the value" do
    card = Card.new('J', 'D')
    expect(card.value).to eq('J')
  end
end