class CampaignCreatorService
  def initialize(team)
    @team = team
  end

  def call
    # Use transaction to ensure data integrity.
    # if any error occurs (e.g., failing to save a player), everything is rolled back.
    ApplicationRecord.transaction do
      campaign = create_campaign
      @team.campaign = campaign
      @team.save!
      create_rival_teams(campaign)
      @team.create_players_for_team
      campaign
    end
  end

  private

  def create_campaign
    Campaign.create!(name: "#{@team.name.capitalize} Campaign")
  end

  def create_rival_teams(campaign)
    9.times do
      rival_team = Team.new(
        name: generate_team_name(campaign),
        campaign: campaign,
        budget: rand(30_000..60_000)
      )
      rival_team.save!
      rival_team.create_players_for_team
    end
  end

  def generate_team_name(campaign)
    first_names = ['Nova', 'York', 'Hawk', 'Bolt', 'Dune', 'Ford', 'Port', 'Lion', 'Tiger', 'Wolf']
    last_names = ['Dynamo', 'Cross', 'Stars', 'Real', 'Eye', 'Sun', 'City', 'United']
    prefixes = ['Soccer', 'Athletic', 'Racing', 'Knights', 'Games', 'Premier', 'Olympique', 'Orient']
    suffixes = ['Club', 'Association', 'Union', 'Sports']

    loop do
      name = "#{first_names.sample} #{last_names.sample} #{prefixes.sample} #{suffixes.sample}"
      unless Team.where(campaign_id: campaign.id, name: name).exists?
        return name
      end
    end
  end
end
