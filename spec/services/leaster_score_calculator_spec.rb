describe LeasterScoreCalculator do
  describe '#score_for' do
    [3, 4, 5].each do |num_players|
      context "when there are #{num_players} players" do
        context 'and a single player has taken a trick' do
          context 'and that player has the least points' do
            it "returns #{num_players - 1}" do
              table = Table.new(num_players)
              table.players = [build(:leaster_winner)]
              while table.players.count < num_players
                table.players << build(:leaster_loser)
              end
              subject = LeasterScoreCalculator.new(table.players)

              expect(subject.score_for(table.players.first)).to eq(num_players - 1)
            end
          end

          context 'and the player has lost' do
            it "returns -1" do
              table = Table.new(num_players)
              table.players = [build(:leaster_winner)]
              while table.players.count < num_players
                table.players << build(:leaster_loser)
              end
              subject = LeasterScoreCalculator.new(table.players)

              (1..num_players - 1).to_a.each do |loser_position|
                expect(subject.score_for(table.players[loser_position])).to eq(-1)
              end
            end
          end
        end

        context 'and all players tie' do
          it "returns 0 for each player's score" do
            table = Table.new(num_players)
            table.players = []
            while table.players.count < num_players
              table.players << build(:leaster_loser)
            end
            subject = LeasterScoreCalculator.new(table.players)

            (1..num_players - 1).to_a.each do |loser_position|
              expect(subject.score_for(table.players[loser_position])).to eq(0)
            end
          end
        end
      end
    end

    context "when the player hasn't taken any tricks" do
      let(:table) { Table.new(3) }
      let(:subject) { LeasterScoreCalculator.new(table.players) }

      it 'returns -1' do
        table.players = [
          build(:leaster_winner),
          build(:leaster_loser),
          build(:no_trick_player)
        ]

        subject = LeasterScoreCalculator.new(table.players)
        expect(subject.score_for(table.players[2])).to eq(-1)
      end
    end

    # test the edge cases where players tie
    context 'when there are 3 players' do
      let(:table) { Table.new(3) }
      let(:subject) { LeasterScoreCalculator.new(table.players) }

      context 'and 2 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 0 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(0)
          expect(subject.score_for(table.players[1])).to eq(0)
        end

        it 'returns -1 point for the loser' do
          expect(subject.score_for(table.players[2])).to eq(-1)
        end
      end
    end

    context 'when there are 4 players' do
      let(:table) { Table.new(4) }
      let(:subject) { LeasterScoreCalculator.new(table.players) }

      context 'and 2 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 1 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(1)
          expect(subject.score_for(table.players[1])).to eq(1)
        end

        it 'returns -1 point for the losers' do
          expect(subject.score_for(table.players[2])).to eq(-1)
          expect(subject.score_for(table.players[3])).to eq(-1)
        end
      end

      context 'and 3 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 0 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(0)
          expect(subject.score_for(table.players[1])).to eq(0)
          expect(subject.score_for(table.players[2])).to eq(0)
        end

        it 'returns -1 point for the loser' do
          expect(subject.score_for(table.players[3])).to eq(-1)
        end
      end
    end

    context 'when there are 5 players' do
      let(:table) { build(:table) }
      let(:subject) { LeasterScoreCalculator.new(table.players) }

      context 'and 2 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser),
            build(:leaster_loser),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 1 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(1)
          expect(subject.score_for(table.players[1])).to eq(1)
        end

        it 'returns -1 point for the losers' do
          expect(subject.score_for(table.players[2])).to eq(-1)
          expect(subject.score_for(table.players[3])).to eq(-1)
          expect(subject.score_for(table.players[4])).to eq(-1)
        end
      end

      context 'and 3 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 0 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(0)
          expect(subject.score_for(table.players[1])).to eq(0)
          expect(subject.score_for(table.players[2])).to eq(0)
        end

        it 'returns -1 point for the losers' do
          expect(subject.score_for(table.players[3])).to eq(-1)
          expect(subject.score_for(table.players[4])).to eq(-1)
        end
      end

      context 'and 4 players tie' do
        before do
          table.players = [
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_winner),
            build(:leaster_loser)
          ]

          subject = LeasterScoreCalculator.new(table.players)
        end

        it 'returns 0 points for each winner' do
          expect(subject.score_for(table.players[0])).to eq(0)
          expect(subject.score_for(table.players[1])).to eq(0)
          expect(subject.score_for(table.players[2])).to eq(0)
          expect(subject.score_for(table.players[3])).to eq(0)
        end

        it 'returns -1 point for the loser' do
          expect(subject.score_for(table.players[4])).to eq(-1)
        end
      end
    end
  end

  describe '#winner?' do
    let(:table) { Table.new(4) }
    let(:subject) { LeasterScoreCalculator.new(table.players) }

    context 'and there is one winner' do
      before do
        table.players = [
          build(:leaster_loser),
          build(:leaster_loser),
          build(:leaster_winner),
          build(:leaster_loser)
        ]

        subject = LeasterScoreCalculator.new(table.players)
      end

      it 'returns true for the winner' do
        expect(subject.winner?(table.players[2])).to eq(true)
      end

      it 'returns false for each loser' do
        expect(subject.winner?(table.players[0])).to eq(false)
        expect(subject.winner?(table.players[1])).to eq(false)
        expect(subject.winner?(table.players[3])).to eq(false)
      end
    end

    context 'and there is a tie' do
      before do
        table.players = [
          build(:leaster_winner),
          build(:leaster_winner),
          build(:leaster_loser),
          build(:leaster_loser)
        ]

        subject = LeasterScoreCalculator.new(table.players)
      end

      it 'returns true for each winner' do
        expect(subject.winner?(table.players[0])).to eq(true)
        expect(subject.winner?(table.players[1])).to eq(true)
      end

      it 'returns false for each loser' do
        expect(subject.winner?(table.players[2])).to eq(false)
        expect(subject.winner?(table.players[3])).to eq(false)
      end
    end
  end

end
