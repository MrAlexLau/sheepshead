class Match
  def initialize(table, options)
    @table = table
    @options = options
    init_scoreboard(@table.players)
  end

  def start
    dealer_seat = rand(1..@options.number_of_players)

    while most_points < @options.points_to_win
      game = Game.new(@options, @table, dealer_seat)
      game.play
      update_scoreboard(game.results)

      puts "######################"
      puts "done with game"
      puts @scoreboard

      dealer_seat += 1
      dealer_seat = @table.adjusted_seat_number(dealer_seat)
    end

  end

  def most_points
    @scoreboard.inject(0) do |max, score|
      (score[1] > max) ? score[1] : max
    end
  end

  private

  # initialize all scores to zero
  def init_scoreboard(players)
    @scoreboard = {}

    players.each do |player|
      @scoreboard[player.name] = 0
    end
  end

  def update_scoreboard(results)
    @scoreboard.keys.each do |key|
      @scoreboard[key] += (results[key] || 0)
    end
  end
end
