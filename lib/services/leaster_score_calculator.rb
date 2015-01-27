class LeasterScoreCalculator
  MAX_POINTS = 120

  def initialize(players)
    @players = players
  end

  def score_for(player)
    # If the player has the least amount of points, return the score per winner
    # If they don't, they lose. Their score is -1.
    self.winner?(player) ? score_per_winner : -1
  end

  def winner?(player)
    player.points == minimum_points
  end

  private

  # return the max possible winner score for a leaster
  # most of the time one player will win
  # but this number is needed in case of ties
  def total_score
    # everyone that didn't have the least amount of points loses,
    # and therefore has a point to giver
    @players.select { |p| p.points != minimum_points }.count
  end

  # This is usually going to be (number of players - 1)
  # But in the event that there is a tie, split the winnings
  #
  # Use integer division to ensure a whole number is returned
  def score_per_winner
    number_of_winners = @players.select { |p| p.points == minimum_points }.count
    (total_score / number_of_winners.to_i)
  end

  def minimum_points
    @minimum_points ||= @players.inject(MAX_POINTS) do |min, player|
      (player.points < min && player.tricks_won.any?) ? player.points : min
    end
  end
end
