describe Deck do
  let(:subject){ Deck.new(5) }
  let(:three_player_deck){ Deck.new(3) }
  let(:four_player_deck){ Deck.new(4) }
  let(:five_player_deck){ Deck.new(5) }

  describe "#cards" do
    context "when there are 3 players" do
      it "has 30 cards in the deck" do
        expect(three_player_deck.cards.count).to eq(30)
      end
    end

    context "when there are 4 players" do
      it "has 32 cards in the deck" do
        expect(four_player_deck.cards.count).to eq(32)
      end
    end

    context "when there are 5 players" do
      it "has 32 cards in the deck" do
        expect(five_player_deck.cards.count).to eq(32)
      end
    end
  end

  describe "#shuffle" do
    it "changes the order of the cards" do
      cards_before = subject.cards.clone

      subject.shuffle
      expect(cards_before).to_not eq(subject.cards)
    end
  end

  describe "#blind_reached?" do
    context "when there are 3 players" do
      before do
        three_player_deck.cards = []
      end

      context "and there are more than 3 cards in the deck" do
        it "returns false" do
          card = build(:card)

          4.times do
            three_player_deck.cards << card
          end
          expect(three_player_deck.blind_reached?).to eq(false)
        end
      end

      context "and there are 3 cards in the deck" do
        it "returns true" do
          card = build(:card)

          3.times do
            three_player_deck.cards << card
          end

          expect(three_player_deck.blind_reached?).to eq(true)
        end
      end
    end

    context "when there are 4 players" do
      before do
        four_player_deck.cards = []
      end

      context "and there are more than 4 cards in the deck" do
        it "returns false" do
          card = build(:card)

          5.times do
            four_player_deck.cards << card
          end
          expect(four_player_deck.blind_reached?).to eq(false)
        end
      end

      context "and there are 3 cards in the deck" do
        it "returns true" do
          card = build(:card)

          4.times do
            four_player_deck.cards << card
          end

          expect(four_player_deck.blind_reached?).to eq(true)
        end
      end
    end

    context "when there are 5 players" do
      before do
        five_player_deck.cards = []
      end

      context "and there are more than 2 cards in the deck" do
        it "returns false" do
          card = build(:card)

          3.times do
            five_player_deck.cards << card
          end
          expect(five_player_deck.blind_reached?).to eq(false)
        end
      end

      context "and there are 2 cards in the deck" do
        it "returns true" do
          card = build(:card)

          2.times do
            five_player_deck.cards << card
          end

          expect(five_player_deck.blind_reached?).to eq(true)
        end
      end
    end
  end

  describe "#pull_top_card!" do
    it "returns the last card in the deck" do
      last_card = subject.cards.last

      expect(subject.pull_top_card!).to eq(last_card)
    end

    it "removes a card from the deck" do
      count_before = subject.cards.count

      subject.pull_top_card!
      expect(subject.cards.count).to eq(count_before - 1)
    end
  end


  describe "#deal_blind" do
    it "increases the number of cards in the blind" do
      count_before = subject.blind.count
      subject.deal_blind
      expect(subject.blind.count).to be > count_before
    end

    it "decreases the number of cards in the deck" do
      count_before = subject.cards.count
      subject.deal_blind
      expect(subject.cards.count).to be < count_before
    end
  end
end
