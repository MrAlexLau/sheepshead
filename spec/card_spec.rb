# card_spec.rb
require 'card'

describe Card do
  let(:all_suits) { ['C', 'S', 'H', 'D'] }

  describe "#initialize" do
    it "sets the suit" do
      card = Card.new('J', 'D')
      expect(card.suit).to eq('D')
    end

    it "sets the value" do
      card = Card.new('J', 'D')
      expect(card.value).to eq('J')
    end
  end

  describe "#to_s" do
    it "returns the concatenated value and suit" do
      card = Card.new('Q', 'S')
      expect(card.to_s).to eq('QS')
    end
  end

  describe "#leading_suit" do
    context "when the card is trump" do
      context "and the suit is diamonds" do
        it "returns T for trump" do
          card = Card.new('7', 'D')
          expect(card.leading_suit).to eq('T')
        end
      end

      context "and the suit is not diamonds" do
        it "returns T for trump" do
          card = Card.new('Q', 'S')
          expect(card.leading_suit).to eq('T')
        end
      end
    end

    context "when the card is not trump" do
      it "returns the card's suit" do
        card = Card.new('7', 'S')
        expect(card.leading_suit).to eq('S')
      end
    end
  end

  describe "#trump?" do
    context "when the suit is diamonds" do
      it "returns true" do
        card = Card.new('7', 'D')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card is a Queen" do
      it "returns true regardless of the suit" do
        card = Card.new('Q', 'S')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card is a Jack" do
      it "returns true regardless of the suit" do
        card = Card.new('J', 'S')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card not a Queen" do
      context "and the card not a Jack" do
        context "and the card does not have the suit diamonds" do
          it "returns false" do
            card = Card.new('K', 'S')
            expect(card.trump?).to eq(false)

            card = Card.new('A', 'C')
            expect(card.trump?).to eq(false)

            card = Card.new('10', 'H')
            expect(card.trump?).to eq(false)
          end
        end
      end
    end
  end

  # don't need to test the actual values,
  # so much as the relations between different trump cards
  describe "#trump_value" do
    context "if the card is not trump" do
      it "returns -1" do
        card = Card.new('8', 'S')
        expect(card.trump_value).to eq(-1)
      end
    end

    it "returns a higher value for 8D than 7D" do
      card_1 = Card.new('8', 'D')
      card_2 = Card.new('7', 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for 9D than 8D" do
      card_1 = Card.new('9', 'D')
      card_2 = Card.new('8', 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for KD than 9D" do
      card_1 = Card.new('K', 'D')
      card_2 = Card.new('9', 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for 10D than KD" do
      card_1 = Card.new('10', 'D')
      card_2 = Card.new('K', 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for AD than 10D" do
      card_1 = Card.new('A', 'D')
      card_2 = Card.new('10', 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for a Jack then AD" do
      all_suits.each do |suit|
        jack_card = Card.new('J', suit)
        ace_card = Card.new('A', 'D')
        expect(jack_card.trump_value).to be > ace_card.trump_value
      end
    end

    it "returns a higher value for a Queen then a Jack" do
      all_suits.each do |queen_suit|
        queen_card = Card.new('Q', queen_suit)
        all_suits.each do |jack_suit|
          jack_card = Card.new('J', jack_suit)
          expect(queen_card.trump_value).to be > jack_card.trump_value
        end
      end
    end

    context 'within the Jack cards' do
      it 'the suit ranks from highest to lowest are C, S, H, D' do
        jack_of_diamonds = Card.new('J', 'D')
        jack_of_hearts = Card.new('J', 'H')
        jack_of_spades = Card.new('J', 'S')
        jack_of_clubs = Card.new('J', 'C')

        expect(jack_of_clubs.trump_value).to be > jack_of_spades.trump_value
        expect(jack_of_spades.trump_value).to be > jack_of_hearts.trump_value
        expect(jack_of_hearts.trump_value).to be > jack_of_diamonds.trump_value
      end
    end

    context 'within the Queen cards' do
      it 'the suit ranks from highest to lowest are C, S, H, D' do
        queen_of_diamonds = Card.new('J', 'D')
        queen_of_hearts = Card.new('J', 'H')
        queen_of_spades = Card.new('J', 'S')
        queen_of_clubs = Card.new('J', 'C')


        expect(queen_of_clubs.trump_value).to be > queen_of_spades.trump_value
        expect(queen_of_spades.trump_value).to be > queen_of_hearts.trump_value
        expect(queen_of_hearts.trump_value).to be > queen_of_diamonds.trump_value
      end
    end
  end

  # don't need to test the actual values,
  # so much as the relations between different cards based on their value
  describe "#nontrump_value" do
    let(:nontrump_suits) { ['C', 'S', 'H'] }
    it "returns a higher value for A than 10" do
      nontrump_suits.each do |suit|
        card_1 = Card.new('A', suit)
        card_2 = Card.new('10', suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 10 than K" do
      nontrump_suits.each do |suit|
        card_1 = Card.new('10', suit)
        card_2 = Card.new('K', suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for K than 9" do
      nontrump_suits.each do |suit|
        card_1 = Card.new('K', suit)
        card_2 = Card.new('9', suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 9 than 8" do
      nontrump_suits.each do |suit|
        card_1 = Card.new('9', suit)
        card_2 = Card.new('8', suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 8 than 7" do
      nontrump_suits.each do |suit|
        card_1 = Card.new('8', suit)
        card_2 = Card.new('7', suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end
  end

  describe "#points" do
    context "when the card is an A" do
      it "returns 11" do
        all_suits.each do |suit|
          card = Card.new('A', suit)
          expect(card.points).to eq(11)
        end
      end
    end

    context "when the card is an 10" do
      it "returns 10" do
        all_suits.each do |suit|
          card = Card.new('10', suit)
          expect(card.points).to eq(10)
        end
      end
    end

    context "when the card is an K" do
      it "returns 4" do
        all_suits.each do |suit|
          card = Card.new('K', suit)
          expect(card.points).to eq(4)
        end
      end
    end

    context "when the card is an Q" do
      it "returns 3" do
        all_suits.each do |suit|
          card = Card.new('Q', suit)
          expect(card.points).to eq(3)
        end
      end
    end

    context "when the card is an J" do
      it "returns 2" do
        all_suits.each do |suit|
          card = Card.new('J', suit)
          expect(card.points).to eq(2)
        end
      end
    end

    context "when the card is a 9, 8, or 7" do
      it "returns 0" do
        ['9', '8', '7'].each do |value|
          all_suits.each do |suit|
            card = Card.new(value, suit)
            expect(card.points).to eq(0)
          end
        end
      end
    end
  end

end
