describe Player do
  describe "#name" do
    describe "#play_card" do
      it "discards a card from the players hand" do
        subject = build(:player_with_hand)
        count_before = subject.hand.count

        subject.play_card([])
        expect(subject.hand.count).to eq(count_before - 1)
      end
    end

    context "when the player is in interactive mode" do
      it "returns 'You'" do
        subject = build(:interactive_player)
        expect(subject.name).to eq('You')
      end
    end

    context "when the player is not in interactive mode" do
      it "returns the player's name" do
        subject.name = 'Jimbo'
        expect(subject.name).to eq('Jimbo')
      end
    end
  end

  describe "#bury!" do
    context "after bury has been called" do
      it "the player should still have the same number of cards in their hand" do
        subject = build(:player_with_hand)
        count_before = subject.hand.count

        subject.bury!(2)
        expect(subject.hand.count).to eq(count_before)
      end
    end
  end

  describe "#check_for_partner!" do
    context "when player has the Jack of diamonds" do
      it "sets the is_partner flag to true" do
        subject = build(:player, hand: [build(:card, value: 'J', suit: 'D')])
        subject.check_for_partner!
        expect(subject.is_partner?).to eq(true)
      end
    end

    context "when player doesn't have the Jack of diamonds" do
      it "sets the is_partner flag to false" do
        subject = build(:player, hand: [build(:card, value: 'J', suit: 'H')])
        subject.check_for_partner!
        expect(subject.is_partner?).to eq(false)
      end
    end
  end

  describe "#points" do
    context "when the player has buried points" do
      let(:buried_cards) {
        [ build(:card, value: '10', suit: 'H'), # 10 points
          build(:card, value: 'J', suit: 'H') ] # 2 points
      }
      it "includes the points in the score" do
        allow(subject).to receive(:blind).and_return(buried_cards)
        expect(subject.points).to eq(12)
      end

      context "and the player has taken tricks" do
        it "returns the sum of the blind and the tricks" do
          trick_1 = build(:trick, cards_played:
            [build(:card, value: 'J', suit: 'H'), # 2 points
            build(:card, value: 'Q', suit: 'C'), # 3 points
            build(:card, value: 'J', suit: 'D')] # 2 points
          )

        allow(subject).to receive(:blind).and_return(buried_cards) # 12 points
        subject.take_trick(trick_1)
        expect(subject.points).to eq(19)
        end
      end
    end

    context "when the player hasn't taken any tricks" do
      context "and the player hasn't buried any points" do
        it "returns 0" do
          expect(subject.points).to eq(0)
        end
      end
    end

    context "when player has taken tricks" do
      it "returns the sum of all cards in those tricks" do
        trick_1 = build(:trick, cards_played:
          [build(:card, value: 'J', suit: 'H'), # 2 points
          build(:card, value: 'Q', suit: 'C'), # 3 points
          build(:card, value: 'J', suit: 'D')] # 2 points
        )

        subject.take_trick(trick_1)
        expect(subject.points).to eq(7)

        trick_2 = build(:trick, cards_played:
          [build(:card, value: 'A', suit: 'H'), # 2 points
          build(:card, value: '10', suit: 'C'), # 10 points
          build(:card, value: 'K', suit: 'D')] # 4 points
        )

        subject.take_trick(trick_2)

        # 7 points from the first trick
        # 25 points from the second trick
        expect(subject.points).to eq(32)
      end
    end
  end

  describe "#take_trick" do
    it "adds the trick to the player's tricks_won" do
      trick = build(:trick)
      expect(subject.tricks_won.count).to eq(0)
      subject.take_trick(trick)
      expect(subject.tricks_won.count).to eq(1)
    end
  end

  describe "#reset!" do
    it "clears the player's hand" do
      subject = build(:player_with_hand)
      subject.reset!
      expect(subject.hand.count).to eq(0)
    end

    it "clears the player's tricks won" do
      trick_1 = build(:trick, cards_played:
        [build(:card, value: 'J', suit: 'H'), # 2 points
        build(:card, value: 'Q', suit: 'C'), # 3 points
        build(:card, value: 'J', suit: 'D')] # 2 points
      )

      subject.take_trick(trick_1)
      subject.reset!
      expect(subject.tricks_won.count).to eq(0)
    end

    it "clears the player's blind" do
      blind = [ build(:card, value: 'J', suit: 'H'), build(:card, value: 'Q', suit: 'C') ]

      subject.blind = blind
      subject.reset!
      expect(subject.blind.count).to eq(0)
    end

    it "clears the player's partner flag" do
      subject.is_partner = true
      subject.reset!
      expect(subject.is_partner).to eq(false)
    end

    it "clears the player's picker flag" do
      subject.is_picker = true
      subject.reset!
      expect(subject.is_picker).to eq(false)
    end
  end
end
