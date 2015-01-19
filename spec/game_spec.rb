describe Game do
  let(:subject) {Game.new(Options.new, Table.new(5), 1)}
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