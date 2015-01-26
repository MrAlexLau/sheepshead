describe Trick do
  let(:table) { build(:table_with_3_players) }
  let(:subject) { Trick.new(table, 1) }

  before do
    subject.cards_played = []

    table.players.each do |player|
      player.interactive = false
    end
  end

  describe '#play' do
    it 'plays a card for each player' do
      table.players.each do |player|
        expect(player).to receive(:play_card)
      end

      subject.play(table.players.count)
    end
  end

  describe '#winner' do
    context 'when there is trump present' do
      it 'returns the player with the highest trump card' do
        subject.cards_played << build(:card, value: '8', suit: 'S')
        subject.cards_played << build(:card, value: 'Q', suit: 'C')
        subject.cards_played << build(:card, value: 'J', suit: 'D')
        expect(subject.winner).to eq(table.players[1])
      end
    end

    context 'when there is no trump present' do
      it 'returns the player with the highest nontrump card that follows suit' do
        subject.cards_played << build(:card, value: '8', suit: 'S')
        subject.cards_played << build(:card, value: 'K', suit: 'C')
        subject.cards_played << build(:card, value: '10', suit: 'H')

        expect(subject.winner).to eq(table.players[0])
      end
    end
  end

  describe '#winning_card' do
    context 'when there is trump present' do
      it 'returns the highest trump card' do
        subject.cards_played << build(:card, value: '8', suit: 'S')
        subject.cards_played << build(:card, value: 'Q', suit: 'C')
        subject.cards_played << build(:card, value: 'J', suit: 'D')
        expect(subject.winning_card).to eq(build(:card, value: 'Q', suit: 'C'))
      end
    end

    context 'when there is no trump present' do
      it 'returns the highest nontrump card that follows suit' do
        subject.cards_played << build(:card, value: '8', suit: 'S')
        subject.cards_played << build(:card, value: 'K', suit: 'C')
        subject.cards_played << build(:card, value: '10', suit: 'H')

        expect(subject.winning_card).to eq(build(:card, value: '8', suit: 'S'))
      end
    end
  end

  describe '#trump_present?' do
    it 'returns true when there is trump present' do
      cards = [
        build(:card, value: '8', suit: 'S'),
        build(:card, value: 'Q', suit: 'C'),
        build(:card, value: 'J', suit: 'D')
      ]

      expect(subject.trump_present?(cards)).to eq(true)
    end

    it 'returns false when there is trump present' do
      cards = [
        build(:card, value: '8', suit: 'S'),
        build(:card, value: '9', suit: 'C'),
        build(:card, value: '10', suit: 'C')
      ]

      expect(subject.trump_present?(cards)).to eq(false)
    end
  end

  describe '#highest_trump_card' do
    it 'returns the trump card with the higest value' do
      cards = [
        build(:card, value: '8', suit: 'S'),
        build(:card, value: 'Q', suit: 'S'),
        build(:card, value: 'Q', suit: 'D'),
        build(:card, value: 'J', suit: 'D')
      ]

      expect(subject.highest_trump_card(cards)).to eq(build(:card, value: 'Q', suit: 'S'))
    end
  end

  describe '#highest_nontrump_card' do
    it 'returns the nontrump card with the higest value of the leading suit' do
      cards = [
        build(:card, value: '8', suit: 'S'),
        build(:card, value: 'A', suit: 'H'),
        build(:card, value: '10', suit: 'S')
      ]

      expect(subject.highest_nontrump_card(cards)).to eq(build(:card, value: '10', suit: 'S'))
    end
  end

  describe '#points' do
    it 'returns the sum of points from all cards in the trick' do
      subject.cards_played << build(:card, value: '8', suit: 'S')
      subject.cards_played << build(:card, value: 'A', suit: 'C')
      subject.cards_played << build(:card, value: '10', suit: 'H')
      subject.cards_played << build(:card, value: 'J', suit: 'H')

      expect(subject.points).to eq(23)
    end
  end
end