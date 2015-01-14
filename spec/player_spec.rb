require 'rule_master'
require 'player_input'
require 'player'
require 'card'
require 'trick'
require 'table'

describe Player do
  describe "#name" do
    describe "#play_card" do
      it "discards a card from the players hand" do
        player = Player.new
        player.hand = [Card.new('A', 'H'), Card.new('9', 'C')]

        player.play_card([])
        expect(player.hand.count).to eq(1)
      end
    end

    context "when the player is in interactive mode" do
      it "returns 'You'" do
        player = Player.new
        player.interactive = true
        expect(player.name).to eq('You')
      end
    end

    context "when the player is not in interactive mode" do
      it "returns the player's name" do
        player = Player.new
        player.name = 'Jimbo'
        expect(player.name).to eq('Jimbo')
      end
    end
  end

  describe "#bury!" do
    context "after bury has been called" do
      it "the player should still have the same number of cards in their hand" do
        player = Player.new
        player.hand = [Card.new('A', 'H'), Card.new('9', 'C'), Card.new('10', 'C')]

        player.bury!(2)
        expect(player.hand.count).to eq(3)
      end
    end
  end

  describe "#check_for_partner!" do
    context "when player has the Jack of diamonds" do
      it "sets the is_partner flag to true" do
        card = Card.new('J', 'D')
        player = Player.new

        player.hand << card

        player.check_for_partner!
        expect(player.is_partner?).to eq(true)
      end
    end

    context "when player doesn't have the Jack of diamonds" do
      it "sets the is_partner flag to false" do
        card = Card.new('J', 'H')
        player = Player.new
        player.check_for_partner!
        expect(player.is_partner?).to eq(false)
      end
    end
  end

  describe "#points" do
    context "when the player hasn't taken any tricks" do
      it "returns 0" do
        player = Player.new
        expect(player.points).to eq(0)
      end
    end

    context "when player has taken tricks" do
      it "returns the sum of all cards in those tricks" do
        trick_1 = Trick.new(Table.new, 1)
        card_1 = Card.new('J', 'H') # 2 points
        card_2 = Card.new('Q', 'C') # 3 points
        card_3 = Card.new('J', 'D') # 2 points

        trick_1.cards_played << card_1
        trick_1.cards_played << card_2
        trick_1.cards_played << card_3

        player = Player.new
        player.take_trick(trick_1)
        expect(player.points).to eq(7)

        trick_2 = Trick.new(Table.new, 1)
        card_4 = Card.new('A', 'H') # 11 points
        card_5 = Card.new('10', 'C') # 10 points
        card_6 = Card.new('K', 'D') # 4 points

        trick_2.cards_played << card_4
        trick_2.cards_played << card_5
        trick_2.cards_played << card_6

        player.take_trick(trick_2)

        # 7 points from the first trick
        # 25 points from the second trick
        expect(player.points).to eq(32)
      end
    end
  end

  describe "#take_trick" do
    it "adds the trick to the player's tricks_won" do
      trick = Trick.new(Table.new, 1)
      player = Player.new
      expect(player.tricks_won.count).to eq(0)
      player.take_trick(trick)
      expect(player.tricks_won.count).to eq(1)
    end
  end
end
