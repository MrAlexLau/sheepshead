describe Dealer do
  let(:subject) { Dealer.new(1, 3) }

  describe '#deal' do
    [3, 4, 5].each do |num_players|
      context "when there are #{num_players} players" do
        it 'should give each player the same number of cards' do
          players = []

          num_players.times do
            players << build(:player)
          end

          dealer = Dealer.new(1, num_players)
          dealer.deal(players)

          cards_per_player = players.first.hand.count
          players.each do |player|
            expect(player.hand.count).to eq(cards_per_player)
          end
        end
      end
    end
  end

  describe '#deal_player' do
    it 'gives the player a card' do
      player = build(:player)
      cards_before = player.hand.count

      top_card = subject.deck.cards.last
      subject.deal_player(player)
      expect(player.hand.last).to eq(top_card)
    end
  end

  describe '#blind_selection' do
    it 'asks players if they want to pick' do
      table = build(:table_with_3_players)
      table.players.each do |player|
        player.interactive = false
      end

      table.players.each do |player|
        expect(player).to receive(:wants_to_pick?)
      end

      subject.blind_selection(table)
    end
  end

end