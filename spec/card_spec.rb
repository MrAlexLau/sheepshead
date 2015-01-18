# card_spec.rb
require 'card'

describe Card do
  let(:all_suits) { ['C', 'S', 'H', 'D'] }

  describe "#initialize" do
    it "sets the suit" do
      card = build(:card, value: 'J', suit: 'D')
      expect(card.suit).to eq('D')
    end

    it "sets the value" do
      card = build(:card, value: 'J', suit: 'D')
      expect(card.value).to eq('J')
    end
  end

  describe "#to_s" do
    it "returns the concatenated value and suit" do
      card = build(:card, value: 'Q', suit: 'S')
      expect(card.to_s).to eq('QS')
    end
  end

  describe "#leading_suit" do
    context "when the card is trump" do
      context "and the suit is diamonds" do
        it "returns T for trump" do
          card = build(:card, value: '7', suit: 'D')
          expect(card.leading_suit).to eq('T')
        end
      end

      context "and the suit is not diamonds" do
        it "returns T for trump" do
          card = build(:card, value: 'Q', suit: 'S')
          expect(card.leading_suit).to eq('T')
        end
      end
    end

    context "when the card is not trump" do
      it "returns the card's suit" do
        card = build(:card, value: '7', suit: 'S')
        expect(card.leading_suit).to eq('S')
      end
    end
  end

  describe "#trump?" do
    context "when the suit is diamonds" do
      it "returns true" do
        card = build(:card, value: '7', suit: 'D')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card is a Queen" do
      it "returns true regardless of the suit" do
        card = build(:card, value: 'Q', suit: 'S')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card is a Jack" do
      it "returns true regardless of the suit" do
        card = build(:card, value: 'J', suit: 'S')
        expect(card.trump?).to eq(true)
      end
    end

    context "when the card not a Queen" do
      context "and the card not a Jack" do
        context "and the card does not have the suit diamonds" do
          it "returns false" do
            card = build(:card, value: 'K', suit: 'S')
            expect(card.trump?).to eq(false)

            card = build(:card, value: 'A', suit: 'C')
            expect(card.trump?).to eq(false)

            card = build(:card, value: '10', suit: 'H')
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
        card = build(:card, value: '8', suit: 'S')
        expect(card.trump_value).to eq(-1)
      end
    end

    it "returns a higher value for 8D than 7D" do
      card_1 = build(:card, value: '8', suit: 'D')
      card_2 = build(:card, value: '7', suit: 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for 9D than 8D" do
      card_1 = build(:card, value: '9', suit: 'D')
      card_2 = build(:card, value: '8', suit: 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for KD than 9D" do
      card_1 = build(:card, value: 'K', suit: 'D')
      card_2 = build(:card, value: '9', suit: 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for 10D than KD" do
      card_1 = build(:card, value: '10', suit: 'D')
      card_2 = build(:card, value: 'K', suit: 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for AD than 10D" do
      card_1 = build(:card, value: 'A', suit: 'D')
      card_2 = build(:card, value: '10', suit: 'D')
      expect(card_1.trump_value).to be > card_2.trump_value
    end

    it "returns a higher value for a Jack then AD" do
      all_suits.each do |suit|
        jack_card = build(:card, value: 'J', suit: suit)
        ace_card = build(:card, value: 'A', suit: 'D')

        expect(jack_card.trump_value).to be > ace_card.trump_value
      end
    end

    it "returns a higher value for a Queen then a Jack" do
      all_suits.each do |queen_suit|
        queen_card = build(:card, value: 'Q', suit: queen_suit)
        all_suits.each do |jack_suit|
          jack_card = build(:card, value: 'J', suit: jack_suit)
          expect(queen_card.trump_value).to be > jack_card.trump_value
        end
      end
    end

    context 'within the Jack cards' do
      it 'the suit ranks from highest to lowest are C, S, H, D' do
        jack_of_diamonds = build(:card, value: 'J', suit: 'D')
        jack_of_hearts = build(:card, value: 'J', suit: 'H')
        jack_of_spades = build(:card, value: 'J', suit: 'S')
        jack_of_clubs = build(:card, value: 'J', suit: 'C')

        expect(jack_of_clubs.trump_value).to be > jack_of_spades.trump_value
        expect(jack_of_spades.trump_value).to be > jack_of_hearts.trump_value
        expect(jack_of_hearts.trump_value).to be > jack_of_diamonds.trump_value
      end
    end

    context 'within the Queen cards' do
      it 'the suit ranks from highest to lowest are C, S, H, D' do
        queen_of_diamonds = build(:card, value: 'Q', suit: 'D')
        queen_of_hearts = build(:card, value: 'Q', suit: 'H')
        queen_of_spades = build(:card, value: 'Q', suit: 'S')
        queen_of_clubs = build(:card, value: 'Q', suit: 'C')


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
        card_1 = build(:card, value: 'A', suit: suit)
        card_2 = build(:card, value: '10', suit: suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 10 than K" do
      nontrump_suits.each do |suit|
        card_1 = build(:card, value: '10', suit: suit)
        card_2 = build(:card, value: 'K', suit: suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for K than 9" do
      nontrump_suits.each do |suit|
        card_1 = build(:card, value: 'K', suit: suit)
        card_2 = build(:card, value: '9', suit: suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 9 than 8" do
      nontrump_suits.each do |suit|
        card_1 = build(:card, value: '9', suit: suit)
        card_2 = build(:card, value: '8', suit: suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end

    it "returns a higher value for 8 than 7" do
      nontrump_suits.each do |suit|
        card_1 = build(:card, value: '8', suit: suit)
        card_2 = build(:card, value: '7', suit: suit)
        expect(card_1.nontrump_value).to be > card_2.nontrump_value
      end
    end
  end

  describe "#points" do
    context "when the card is an A" do
      it "returns 11" do
        all_suits.each do |suit|
          card = build(:card, value: 'A', suit: suit)
          expect(card.points).to eq(11)
        end
      end
    end

    context "when the card is an 10" do
      it "returns 10" do
        all_suits.each do |suit|
          card = build(:card, value: '10', suit: suit)
          expect(card.points).to eq(10)
        end
      end
    end

    context "when the card is an K" do
      it "returns 4" do
        all_suits.each do |suit|
          card = build(:card, value: 'K', suit: suit)
          expect(card.points).to eq(4)
        end
      end
    end

    context "when the card is an Q" do
      it "returns 3" do
        all_suits.each do |suit|
          card = build(:card, value: 'Q', suit: suit)
          expect(card.points).to eq(3)
        end
      end
    end

    context "when the card is an J" do
      it "returns 2" do
        all_suits.each do |suit|
          card = build(:card, value: 'J', suit: suit)
          expect(card.points).to eq(2)
        end
      end
    end

    context "when the card is a 9, 8, or 7" do
      it "returns 0" do
        ['9', '8', '7'].each do |value|
          all_suits.each do |suit|
            card = build(:card, value: value, suit: suit)
            expect(card.points).to eq(0)
          end
        end
      end
    end
  end

end
