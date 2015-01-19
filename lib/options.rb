class Options
  def initialize(opt_hash={})
    defaults = {
      number_of_players: 3,
      points_to_win: 50
    }

    @options = defaults.merge(opt_hash)
  end

  def [](key)
    @options[key]
  end

  def number_of_players
    @options[:number_of_players]
  end

  def number_of_players=(num)
    @options[:number_of_players] = num
  end

  def points_to_win
    @options[:points_to_win]
  end

  def points_to_win=(num)
    @options[:points_to_win] = num
  end

  def to_s
    str = "Options:\n"
    @options.each do |key, value|
      str += "#{key}: #{value}\n"
    end

    str
  end
end
