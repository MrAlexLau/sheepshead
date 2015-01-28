describe ScoreCalculator do
  describe '#score_for' do
    context 'when the picker is playing solo' do
      [3, 4, 5].each do |num_players|
        let(:table) { Table.new(num_players) }
        let(:picker) { table.players.first }
        let(:subject) { ScoreCalculator.new(table.players) }
        before do
          table.players = [
            build(:no_trick_player, is_picker: true, is_partner: (num_players == 5))
          ]

          while table.players.count < num_players
            table.players << build(:single_trick_player)
          end

          subject = ScoreCalculator.new(table.players)
        end

        context "when there are #{num_players} players" do
          context "and the picker hasn't taken any tricks" do
            context "score_for the picker" do
              it "returns -24" do
                expect(subject.score_for(picker)).to eq(-24)
              end
            end

            context "score_for the defenders" do
              it "returns 6" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(6) unless player.is_picker?
                end
              end
            end
          end

          context "and the picker has taken 30 points" do
            before do
              picker.tricks_won << build(:thirty_point_trick)
            end

            context "score_for the picker" do
              it "returns -16" do
                expect(subject.score_for(picker)).to eq(-16)
              end
            end

            context "score_for the defenders" do
              it "returns 4" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(4) unless player.is_picker?
                end
              end
            end
          end

          context "and the picker has taken 60 points" do
            before do
              picker.tricks_won << build(:sixty_point_trick)
            end

            context "score_for the picker" do
              it "returns -8" do
                expect(subject.score_for(picker)).to eq(-8)
              end
            end

            context "score_for the defenders" do
              it "returns 2" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(2) unless player.is_picker?
                end
              end
            end
          end

          context "and the picker has taken 90 points" do
            before do
              picker.tricks_won << build(:ninety_point_trick)
            end

            context "score_for the picker" do
              it "returns 4" do
                expect(subject.score_for(picker)).to eq(4)
              end
            end

            context "score_for the defenders" do
              it "returns -1" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(-1) unless player.is_picker?
                end
              end
            end
          end

          context "and the picker has taken 120 points" do
            before do
              picker.tricks_won << build(:one_twenty_point_trick)
            end

            context "score_for the picker" do
              it "returns 8" do
                expect(subject.score_for(picker)).to eq(8)
              end
            end

            context "score_for the defenders" do
              it "returns -2" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(-2) unless player.is_picker?
                end
              end
            end
          end

          context "and the picker has taken all of the tricks" do
            before do
              table.players = [
                build(:single_trick_player, is_picker: true, is_partner: (num_players == 5))
              ]

              while table.players.count < num_players
                table.players << build(:no_trick_player)
              end

              subject = ScoreCalculator.new(table.players)
            end

            context "score_for the picker" do
              it "returns 12" do
                expect(subject.score_for(picker)).to eq(12)
              end
            end

            context "score_for the defenders" do
              it "returns -3" do
                table.players.each do |player|
                  expect(subject.score_for(player)).to eq(-3) unless player.is_picker?
                end
              end
            end
          end
        end
      end
    end
  end

  context 'when there are 5 players and the picker has a partner' do
    let(:table) { Table.new(5) }
    let(:subject) { ScoreCalculator.new(table.players) }
    let(:picker) { table.players[0] }
    let(:partner) { table.players[1] }

    before do
      table.players = [
        build(:no_trick_player, is_picker: true),
        build(:no_trick_player, is_partner: true)
      ]

      while table.players.count < 5
        table.players << build(:single_trick_player)
      end

      subject = ScoreCalculator.new(table.players)
    end

    context "and the picking team hasn't taken any tricks" do
      context "score_for the picker" do
        it "returns -12" do
          expect(subject.score_for(picker)).to eq(-12)
        end
      end

      context "score_for the partner" do
        it "returns -6" do
          expect(subject.score_for(partner)).to eq(-6)
        end
      end
    end

    context "and the picking team has taken 30 points" do
      before do
        partner.tricks_won << build(:thirty_point_trick)
      end

      context "score_for the picker" do
        it "returns -8" do
          expect(subject.score_for(picker)).to eq(-8)
        end
      end

      context "score_for the partner" do
        it "returns -4" do
          expect(subject.score_for(partner)).to eq(-4)
        end
      end
    end

    context "and the picking team has taken 60 points" do
      before do
        picker.tricks_won << build(:sixty_point_trick)
      end

      context "score_for the picker" do
        it "returns -4" do
          expect(subject.score_for(picker)).to eq(-4)
        end
      end

      context "score_for the partner" do
        it "returns -2" do
          expect(subject.score_for(partner)).to eq(-2)
        end
      end
    end

    context "and the picking team has taken 90 points" do
      before do
        picker.tricks_won << build(:ninety_point_trick)
      end

      context "score_for the picker" do
        it "returns 2" do
          expect(subject.score_for(picker)).to eq(2)
        end
      end

      context "score_for the partner" do
        it "returns 1" do
          expect(subject.score_for(partner)).to eq(1)
        end
      end
    end

    context "and the picking team has taken 120 points" do
      before do
        picker.tricks_won << build(:one_twenty_point_trick)
      end

      context "score_for the picker" do
        it "returns 4" do
          expect(subject.score_for(picker)).to eq(4)
        end
      end

      context "score_for the partner" do
        it "returns 2" do
          expect(subject.score_for(partner)).to eq(2)
        end
      end
    end

    context "and the picking team has all of the tricks" do
      before do
        table.players = [
          build(:single_trick_player, is_picker: true),
          build(:single_trick_player, is_partner: true)
        ]

        while table.players.count < 5
          table.players << build(:no_trick_player)
        end

        subject = ScoreCalculator.new(table.players)
      end

      context "score_for the picker" do
        it "returns 6" do
          expect(subject.score_for(picker)).to eq(6)
        end
      end

      context "score_for the partner" do
        it "returns 3" do
          expect(subject.score_for(partner)).to eq(3)
        end
      end
    end
  end

end
