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

  private

  def generate_player_name
    first_names = [
      'John', 'Jack', 'Paul', 'Mark', 'Adam', 'Liam', 'Noah', 'Ryan', 'Eric', 'Alan',
      'Alex', 'Bill', 'Carl', 'Dave', 'Dean', 'Evan', 'Fred', 'Gary', 'Glen', 'Hugo',
      'Ivan', 'Jake', 'Joel', 'Josh', 'Kyle', 'Leon', 'Luke', 'Matt', 'Mike', 'Neil',
      'Nick', 'Owen', 'Pete', 'Rick', 'Sean', 'Seth', 'Tony', 'Troy', 'Will', 'Zack',
      'Ben', 'Dan', 'Joe', 'Tom', 'Max', 'Sam', 'Roy', 'Leo', 'Ian', 'Cole', 'Noa',
      'Enzo', 'Luan', 'Gael', 'Ravi', 'Otto', 'José', 'João', 'Caio', 'Raul', 'Yuri',
      'Juan', 'Jair', 'Tito', 'Saul', 'Iago', 'Eder', 'Igor', 'Alan'
    ]
    last_names = [
      'Bell', 'Bond', 'Bush', 'Best', 'Bird', 'Cruz', 'Cook', 'Cox', 'Cole', 'Carr',
      'Clay', 'Day', 'Dean', 'Dunn', 'Dye', 'Ford', 'Fox', 'Fry', 'Gray', 'Gill',
      'Hall', 'Hill', 'Hunt', 'Hart', 'Hood', 'Holt', 'King', 'Kent', 'Kerr', 'Lee',
      'Lane', 'Long', 'Law', 'Lamb', 'Lowe', 'May', 'Mann', 'Moon', 'Moss', 'Nash',
      'Park', 'Page', 'Pope', 'Reed', 'Rosa', 'Ross', 'Rice', 'Shaw', 'Snow', 'Ward',
      'Wood', 'West', 'Webb', 'Wolf', 'York', 'Braz', 'Reis', 'Lima', 'Lobo', 'Rios',
      'Melo', 'Rosa', 'Paes', 'Pena', 'Sena', 'Mota', 'Gama', 'Lins'
    ]

    loop do
      name = "#{first_names.sample} #{last_names.sample}"
      # Ensure the player name is unique within the campaign
      unless Player.joins(:team).where(teams: { campaign_id: self.campaign_id }, players: { name: name }).exists?
        return name
      end
    end
  end
end
