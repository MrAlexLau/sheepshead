describe Table do
  before do
    # turn off interactive mode for testing
    subject.players.each do |player|
      player.interactive = false
    end
  end

  describe "#player_at_seat" do
    it "returns the player at a given seat number" do
      (1..5).to_a.each do |num|
        expect(subject.player_at_seat(num).name).to eq("Player #{num}")
      end
    end

    it "returns nil when the seat number is outside of the range of players" do
      expect(subject.player_at_seat(6)).to be_nil
    end
  end

  describe "#adjusted_seat_number" do
    context "when there are 5 players" do
      context "and the seat_number argument is within 1 and 5" do
        it "returns the seat number" do
          (1..5).to_a.each do |num|
            expect(subject.adjusted_seat_number(num)).to eq(num)
          end
        end
      end

      context "and the seat_number argument greater than the number of players (eg: 7)" do
        it "rolls around back to the front seats (and returns 2 in this example)" do
          expect(subject.adjusted_seat_number(7)).to eq(2)
        end
      end

      context "and the seat_number argument is 0" do
        it "rolls around back to the last seat and returns 5" do
          expect(subject.adjusted_seat_number(0)).to eq(5)
        end
      end

      context "and the seat_number argument is less than zero" do
        it "raises an exception" do
          expect { subject.adjusted_seat_number(-1) }.to raise_exception
        end
      end
    end
  end

  describe "#teams" do
    context "when there are 5 players" do
      context "and the picker and partner are 2 separate players" do
        it "returns 2 players on the picking team and 3 on the other team" do
          subject.players[2].is_picker = true
          subject.players[4].is_partner = true

          expect(subject.teams['Picking Team'].count).to eq(2)
          expect(subject.teams['Other Team'].count).to eq(3)
        end
      end

      context "and the picker and partner are the same player" do
        it "returns 1 player on the picking team and 4 on the other team" do
            subject.players[2].is_picker = true
            subject.players[2].is_partner = true

            expect(subject.teams['Picking Team'].count).to eq(1)
            expect(subject.teams['Other Team'].count).to eq(4)
        end
      end
    end
  end
end
