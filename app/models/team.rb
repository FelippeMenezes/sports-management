class Team < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :campaign

  has_many :players

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"

  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"

  def create_players_for_team
    positions = %w[G G D D D D D M M M M M A A A]

    positions.each do |position|
      player = Player.new(
        name: generate_player_name,
        position: position,
        level: rand(1..10),
        yellow_card: 0,
        red_card: 0,
        injury: false,
        team: self
      )
      player.save!
    end
  end

  def create_campaign
    @campaign = Campaign.create!(name: "#{self.name.capitalize} Campaign")
    self.campaign = @campaign
    create_rival_teams(@campaign)
    self.create_players_for_team
    campaign
  end

  def create_rival_teams(campaign)
    9.times do
      rival_team = Team.new(
        name: generate_team_name,
        campaign: campaign,
        budget: rand(30_000..60_000)
      )
      rival_team.save!
      rival_team.create_players_for_team
    end
  end

  private

  def generate_player_name
    first_names = [
      'John', 'Jack', 'Paul', 'Mark', 'Adam', 'Liam', 'Noah', 'Ryan', 'Eric', 'Alan',
      'Alex', 'Bill', 'Carl', 'Dave', 'Dean', 'Evan', 'Fred', 'Gary', 'Glen', 'Hugo',
      'Ivan', 'Jake', 'Joel', 'Josh', 'Kyle', 'Leon', 'Luke', 'Matt', 'Mike', 'Neil',
      'Nick', 'Owen', 'Pete', 'Rick', 'Sean', 'Seth', 'Tony', 'Troy', 'Will', 'Zack',
      'Ben', 'Dan', 'Joe', 'Tom', 'Max', 'Sam', 'Roy', 'Leo', 'Ian', 'Cole'
    ]
    last_names = [
      'Bell', 'Bond', 'Bush', 'Best', 'Bird', 'Ball', 'Cook', 'Cox', 'Cole', 'Carr',
      'Clay', 'Day', 'Dean', 'Dunn', 'Dye', 'Ford', 'Fox', 'Fry', 'Gray', 'Gill',
      'Hall', 'Hill', 'Hunt', 'Hart', 'Hood', 'Holt', 'King', 'Kent', 'Kerr', 'Lee',
      'Lane', 'Long', 'Law', 'Lamb', 'Lowe', 'May', 'Mann', 'Moon', 'Moss', 'Nash',
      'Park', 'Page', 'Pope', 'Reed', 'Rose', 'Ross', 'Rice', 'Shaw', 'Snow', 'Ward',
      'Wood', 'West', 'Webb', 'Wolf', 'York'
    ]

    loop do
      name = "#{first_names.sample} #{last_names.sample}"
      # Ensure the player name is unique within the campaign
      unless Player.joins(:team).where(teams: { campaign_id: self.campaign_id }, players: { name: name }).exists?
        return name
      end
    end
  end

  def generate_team_name
    fisrt_names = ['Nova', 'York', 'Hawk', 'Bolt', 'Dune', 'Ford', 'Port', 'Lion', 'Tiger', 'Wolf']
    last_names = ['Dyanmo', 'Cross', 'Stars', 'Real', 'Eye', 'Sun', 'City', 'United']
    prefixes = ['Soccer', 'Athletic', 'Racing', 'Knights', 'Games', 'Premier', 'Olympique', 'Orient']
    suffixes = ['Club', 'Association', 'Union', 'Sports', 'Union']

    loop do
      name = "#{fisrt_names.sample} #{last_names.sample} #{prefixes.sample} #{suffixes.sample}"
      # Ensure the team name is unique within the campaign
      unless Team.where(campaign_id: self.campaign_id, name: name).exists?
        return name
      end
    end
  end
end
