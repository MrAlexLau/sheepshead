class ScoreCalculator
  SCORES = {
    all_tricks_for_pickers: {
      solo_picker: 12,
      team_picker: 6,
      partner: 3,
      defender: -3
    },
    no_tricks_for_pickers: {
      solo_picker: -24,
      team_picker: -12,
      partner: -6,
      defender: 6
    },
    at_least_91: {
      solo_picker: 8,
      team_picker: 4,
      partner: 2,
      defender: -2
    },
    at_least_61: {
      solo_picker: 4,
      team_picker: 2,
      partner: 1,
      defender: -1
    },
    at_least_31: {
      solo_picker: -8,
      team_picker: -4,
      partner: -2,
      defender: 2
    },
    below_31: {
      solo_picker: -16,
      team_picker: -8,
      partner: -4,
      defender: 4
    }
  }

  def initialize(players)
    @players = players
  end

  def score_for(player)
    if playing_solo?(player)
      score_tier[:solo_picker]
    elsif player.is_picker?
      score_tier[:team_picker]
    elsif player.is_partner?
      score_tier[:partner]
    else # on defending team
      score_tier[:defender]
    end
  end

  private

  def score_tier
    # picking team took all tricks
    return SCORES[:all_tricks_for_pickers] if defending_team_took_zero_tricks?

    # picking team took zero tricks
    return SCORES[:no_tricks_for_pickers] if picking_team_took_zero_tricks?

    case picking_teams_points
    when 91..120
      SCORES[:at_least_91]
    when 61..90
      SCORES[:at_least_61]
    when 31..60
      SCORES[:at_least_31]
    when 0..30
      SCORES[:below_31]
    end
  end

  def picking_team_took_zero_tricks?
    @picking_team_took_zero_tricks ||= (picking_team.inject(0) { |sum, player| sum + player.tricks_won.count } == 0)
  end

  def defending_team_took_zero_tricks?
    @defending_team_took_zero_tricks ||= (defending_team.inject(0) { |sum, player| sum + player.tricks_won.count } == 0)
  end

  def playing_solo?(player)
    picker_is_partner = (player.is_picker? && player.is_partner?)
    picker_is_partner || (player.is_picker? && !partner_present?)
  end

  # will be false for 3 and 4 player games
  # doing the query abstracts better than passing the game mode
  def partner_present?
    @players.select { |player| player.is_partner? }.any?
  end

  def picking_teams_points
    @picking_teams_points ||= picking_team.inject(0) { |sum, player| sum + player.points }
  end

  def defending_team
    @defending_team = @players.select { |player| !player.is_picker? && !player.is_partner? }
  end

  def picking_team
    @picking_team = @players.select { |player| player.is_picker? || player.is_partner? }
  end
end
