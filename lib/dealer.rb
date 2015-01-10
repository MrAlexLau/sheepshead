class Dealer
  attr_accessor :deck

  def initialize
    @deck = Deck.new
  end

  # deals the entire deck to the players
  def deal(players)
    num_players = players.count
    deck.shuffle

    player_index = 0
    while !deck.blind_reached?
      deal_player(players[player_index % num_players])
      player_index += 1
    end
  end

  def blind
    deck
  end

  def deal_player(player)
    player.hand << deck.pull_top_card!
  end
end
