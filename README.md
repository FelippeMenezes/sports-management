# Sports Management

Este é um projeto de gerenciamento esportivo desenvolvido com Ruby on Rails, projetado para simular a criação e gestão de campanhas de futebol. A aplicação utiliza processamento em segundo plano com **Sidekiq** e **Redis** para oferecer uma experiência de usuário fluida durante operações demoradas, como a criação de uma nova campanha com múltiplos times e jogadores.

---

## ✨ Funcionalidades Principais

- **Autenticação de Usuários:** Sistema completo de cadastro e login com **Devise**.
- **Criação de Campanhas:** Geração de um time para o usuário e múltiplos times rivais controlados pela IA.
- **Geração Automática de Jogadores:** Cada time é populado com jogadores gerados aleatoriamente, com posições e níveis distintos.
- **Processamento em Segundo Plano:** A criação de campanhas, uma tarefa pesada, é executada como um job em background com **Sidekiq**, evitando que a interface do usuário trave.
- **Barra de Progresso em Tempo Real:** O usuário acompanha o status da criação da campanha através de uma barra de progresso que é atualizada dinamicamente via **StimulusJS** e **Sidekiq-Status**.
- **Controle de Acesso:** Autorização baseada em regras de negócio com **Pundit**.

---

## 🚀 Tecnologias Utilizadas

### Backend
- **Ruby:** `3.1.4`
- **Rails:** `~> 7.1.5`
- **Banco de Dados:** PostgreSQL (`pg` gem)
- **Servidor Web:** Puma
- **Jobs em Background:** Sidekiq
- **Fila de Jobs:** Redis
- **Monitoramento de Jobs:** Sidekiq-Status
- **Autenticação:** Devise
- **Autorização:** Pundit

### Frontend
- **JavaScript Framework:** Hotwire (Turbo e Stimulus)
 - **Gerenciador de Pacotes JS:** Importmap
- **Framework CSS:** Bootstrap `~> 5.3` com Sass (`sassc-rails`)
- **Ícones:** Font Awesome
- **Formulários:** Simple Form

### Desenvolvimento e Testes
- **Variáveis de Ambiente:** `dotenv-rails`
- **Debugging:** `debug`, `pry-byebug`, `pry-rails`
- **Testes:** RSpec e Factory Bot

---

## ⚙️ Configuração do Ambiente Local

### Pré-requisitos
- **Ruby** na versão `3.1.4`. Recomenda-se o uso de um gerenciador de versões como `rbenv` ou `asdf`.
- **Bundler**
- **PostgreSQL** instalado e rodando.
- **Redis** instalado e rodando.

### Passos para Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/FelippeMenezes/sports-management.git
    cd sports-management
    ```

2.  **Instale as dependências do Ruby:**
    ```bash
    bundle install
    ```

3.  **Configure o banco de dados PostgreSQL:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Inicie os serviços em terminais separados:**

    Para que a aplicação funcione corretamente, você precisa iniciar **três processos** em **três terminais diferentes**:

    - **Terminal 1: Inicie o Redis**
      _**Nota:** Se você instalou o Redis usando `brew` (macOS) ou `apt` (Linux) e o configurou como um serviço que inicia com o sistema, ele já deve estar rodando em segundo plano. Nesse caso, você pode pular este passo e precisará de apenas dois terminais._
      ```bash
      redis-server
      ```

    - **Terminal 2: Inicie o Sidekiq Worker** para processar os jobs:
      ```bash
      bundle exec sidekiq
      ```

    - **Terminal 3: Inicie o servidor Rails:**
    ```bash
    rails s
    ```

Agora você pode acessar a aplicação em `http://localhost:3000`.

---

## ☁️ Deploy (Hospedagem)

Este projeto está configurado para deploy contínuo na plataforma **Render.com** (plano gratuito).

### Serviços Utilizados
- **Web Service:** Ambiente `Ruby`.
- **Database:** `PostgreSQL`.

### Configuração na Render
- **Build Command:** `./render-build.sh`
- **Start Command:** `bundle exec rails server`

### Variáveis de Ambiente Necessárias
As seguintes variáveis de ambiente devem ser configuradas no serviço web da Render:
- `DATABASE_URL`: Fornecida automaticamente pela Render ao conectar com o serviço de PostgreSQL interno.
- `RAILS_MASTER_KEY`: Conteúdo do arquivo `config/master.key`.
- `RAILS_SERVE_STATIC_FILES`: `true`

O script `render-build.sh` cuida da instalação das dependências, pré-compilação dos assets e migração do banco de dados a cada deploy.
