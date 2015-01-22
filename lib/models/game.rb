class Game
  def initialize(options, table, dealer_seat)
    @options = options
    @dealer = Dealer.new(dealer_seat, @options.number_of_players)
    @table = table
    @tricks_played = 0
  end

  def play
    @dealer.deal(players)
    @picker = @dealer.blind_selection(@table)

    # start with the person to the left of the dealer
    leaders_seat = @table.adjusted_seat_number(@dealer.seat_number + 1)

    if self.leaster?
      puts "----------------------"
      puts "Leaster!"
    end

    while !game_over?
      puts "----------------------"

      trick = Trick.new(@table, leaders_seat)
      trick.play(players.count)
      @tricks_played += 1

      leaders_seat = trick.winner.seat_number
      trick.winner.take_trick(trick)
      puts "Cards played this trick: #{trick.cards_played.join(', ')}"
      puts "This trick was worth #{trick.points} points."
      puts "Trick Winner: #{trick.winner} with #{trick.winning_card}"
      puts "----------------------"
    end

    calculate_results
    display_game_results

    clear_player_hands!
  end

  def calculate_results
    @results = {}

    if self.leaster?
      score_keeper = LeasterScoreCalculator.new(players)
      @table.players.each do |player|
        @results[player.name] = score_keeper.score_for(player)
      end
    else
      # TODO: calculate normal game scores
    end

    @results
  end

  def results
    @results
  end



  def display_game_results
    if self.leaster?
      players.each do |player|
        puts "(#{player.name}): #{player.points} points, #{player.tricks_won.count} tricks"
      end
      puts "#{leaster_winner.name} wins!"
    else
      teams.each do |team, players|
        _points = players.inject(0) { |sum, player| sum + player.points }
        players_names = players.map { |player| player.name }.join(", ")
        puts "#{team} (#{players_names}): #{_points} points"
      end
    end
  end

  def game_over?
    case @options.number_of_players
    when 3
      @tricks_played >= 9
    when 4
      @tricks_played >= 7
    when 5
      @tricks_played >= 6
    else
      raise 'Invalid number of players'
    end
  end

  def leaster?
    !@picker
  end

  # TODO: add a check for ties
  def leaster_winner
    players.inject(players.first) do |winner, player|
      (player.points <= winner.points && player.tricks_won.any?) ? player : winner
    end
  end

  # TODO: add a check for ties
  def normal_game_winner
    players.inject(players.first) do |winner, player|
      (player.points >= winner.points) ? player : winner
    end
  end

  def teams
    if players.count == 5
      {
        'Picking Team' => players.select { |player| player.is_picker? || player.is_partner? },
        'Other Team' => players.select { |player| !player.is_picker? && !player.is_partner? }
      }
    else
      {
        'Picking Team' => players.select { |player| player.is_picker? },
        'Other Team' => players.select { |player| !player.is_picker? }
      }
    end
  end

  def players
    @table.players
  end

  # debugging
  def game_status
    puts 'Here are the hands for each player:'
    players.each do |player|
      puts player.name
      puts player.hand
      puts "is picker: #{player.is_picker}"
      puts "is partner: #{player.is_partner}"
    end

    puts "blind: #{@dealer.blind}"
  end

  def clear_player_hands!
    players.each do |player|
      player.hand = []
      player.tricks_won = []
      player.blind = []
    end
  end
end
