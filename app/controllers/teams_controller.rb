class TeamsController < ApplicationController
  before_action :authenticate_user!
  def index
    @teams = current_user.teams
  end

  def show
    @team = current_user.teams.find(params[:id])
    @rival_teams = Team.where(user_id: nil)
    puts @rival_teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    campaign = Campaign.create!(name: "#{@team.name.capitalize} Campaign")
    @team.campaign = campaign
    create_rival_teams(campaign)
    create_players_for_team(@team)
    if @team.save
      redirect_to team_path(@team)
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def generate_player_name
    first_names = [
      'João', 'Pedro', 'Carlos', 'Luis', 'André', 'Rafael', 'Bruno', 'Diego', 'Felipe', 'Gabriel',
      'Marcos', 'Paulo', 'Ricardo', 'Fernando', 'Roberto', 'Alexandre', 'Rodrigo', 'Daniel', 'Thiago', 'Leonardo',
      'Lucas', 'Matheus', 'Vinícius', 'Eduardo', 'Marcelo', 'Vitor', 'Gustavo', 'Henrique', 'Júlio',
      'Ramon', 'Murilo', 'Elias', 'Breno', 'César', 'Hugo', 'Samuel', 'Túlio', 'Otávio', 'Cauã',
      'Miguel', 'Benício', 'Antônio', 'Davi', 'Erick'
    ]
    last_names = [
      'Silva', 'Santos', 'Oliveira', 'Souza', 'Lima', 'Costa', 'Pereira', 'Alves', 'Ferreira', 'Rodrigues',
      'Carvalho', 'Araújo', 'Gomes', 'Barbosa', 'Rocha', 'Dias', 'Monteiro', 'Cardoso', 'Reis',
      'Paulista', 'Carioca', 'Paraíba', 'Mineiro', 'Gaúcho', 'Pará', 'Goiano', 'Baiano'
    ]

    "#{first_names.sample} #{last_names.sample}"
  end

  def generate_team_name
    team_name = [
      'Flamingo', 'Cristovão Colombo', 'Três Marias', 'Litoral', 'Vale Alto',
      'Interior', 'Capital', 'Nacional', 'Praia', 'Montanha'
    ]
    suffixes = ['FC', 'CF', 'AF', 'SC']

    "#{team_name.sample} #{suffixes.sample}"
  end

  def create_players_for_team(team)
    positions = %w[G G D D D D D M M M M M A A A]

    positions.each do |position|
      player = Player.new(
        name: generate_player_name,
        position: position,
        level: rand(1..10),
        yellow_card: 0,
        red_card: 0,
        injury: false,
        team: team
      )
      player.save!
    end
  end

  def create_rival_teams(campaign)
    9.times do
        rival_team = Team.new(
        name: generate_team_name,
        campaign: campaign,
        budget: rand(30_000..60_000)
      )
      create_players_for_team(rival_team)
      rival_team.save!
    end
  end
end
