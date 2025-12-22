class CampaignCreatorService
  NUMBER_OF_RIVALS = 9

  # The initializer now accepts the 'job' as an optional argument.
  def initialize(user_id, team_params, job = nil)
    @user = User.find(user_id)
    @team_params = team_params
    @job = job
    @current_step = 0

    # Define the total number of steps dynamically.
    # 1 (Starting) + 1 (create campaign) + 1 (create main team) + N (rivals) + 1 (finalize)
    @total_steps = 4 + NUMBER_OF_RIVALS

    # Initialize and shuffle name components to ensure uniqueness per generation
    @first_names = ['Cosmos', 'Nova', 'Capital', 'Solar', 'Tropical', 'Rural', 'Opera', 'Oasis',  'Mineral', 'Animal', 'Formula', 'Lava', 'Natural', 'Panda', 'Prisma', 'Zebra'].shuffle
    @last_names = ['Elite', 'Atlas', 'Titan', 'Bravo', 'Delta', 'Popular', 'Base', 'Canal', 'Coral', 'Junior'].shuffle
    @prefixes = ['Premier', 'Metro', 'Central', 'Social', 'Original', 'Naval', 'Principal', 'Real', 'Regular', 'Terminal'].shuffle
    @suffixes = ['FC', 'AA', 'UA', 'CR', 'AF', 'CF', 'AC', 'RF', 'RC', 'UC'].shuffle
  end

  def call
    # Starting a transaction. If something goes wrong, everything is rolled back.
    ActiveRecord::Base.transaction do
      report_progress("Starting campaign creation...")

      # 1. Create the Campaign
      campaign = Campaign.create!(
        name: "#{@team_params[:name]} Campaign"
      )
      report_progress("Campaign '#{campaign.name}' created.")

      # 2. Create the User's Team
      team = Team.create!(
        name: @team_params[:name],
        user: @user,
        campaign: campaign,
        budget: 100_000
      )
      team.create_players_for_team # Calls the model method to create players
      report_progress("Your team, '#{team.name}', has been created.")

      # 3. Create Rival Teams
      NUMBER_OF_RIVALS.times do |i|
        rival_name = "#{generate_team_name(campaign)}"
        rival_team = Team.create!(
          name: rival_name,
          user: nil,
          campaign: campaign,
          budget: rand(30_000..60_000)
        )
        rival_team.create_players_for_team
        report_progress("Creating team: #{rival_name}")
      end

      report_progress("Finalizing preparations...")
      return team # Returns the main team created
    end
  end

  private

  def report_progress(message)
    @current_step += 1
    # The 'at' method comes from 'sidekiq-status' and updates the job progress.
    # The API expects the percentage (0-100) and the message.
    percentage = (@current_step * 100) / @total_steps
    @job&.at(percentage, message)
  end

  def generate_team_name(campaign)
    "#{@first_names.pop} #{@last_names.pop} #{@prefixes.pop} #{@suffixes.pop}"
  end
end
