# Sports Management

Este é um projeto de gerenciamento esportivo desenvolvido com Ruby on Rails.

---

## 🚀 Tecnologias e Dependências

### Core
- **Ruby:** `3.1.4`
- **Rails:** `~> 7.1.5`
- **Banco de Dados:** PostgreSQL (`pg` gem)
- **Servidor Web:** Puma

### Frontend
- **Framework CSS:** Bootstrap `~> 5.3`
- **Pré-processador CSS:** Sass (`sassc-rails`)
- **Ícones:** Font Awesome `~> 6.1`
- **JavaScript:** Importmap para gerenciamento de pacotes, com Turbo e Stimulus para uma experiência de usuário moderna e reativa.

### Autenticação e Formulários
- **Autenticação:** Devise para gerenciamento de usuários.
- **Formulários:** Simple Form para criação de formulários elegantes e eficientes.

### Ambiente de Desenvolvimento
- **Variáveis de Ambiente:** `dotenv-rails` para gerenciar chaves e configurações.
- **Debugging:** `debug`, `pry-byebug` e `pry-rails`.

---

## ⚙️ Configuração do Ambiente Local

Siga os passos abaixo para rodar o projeto na sua máquina.

### Pré-requisitos
- **Ruby** na versão `3.1.4`. Recomenda-se o uso de um gerenciador de versões como `rbenv` ou `asdf`.
- **Bundler**
- **PostgreSQL** instalado e rodando.

### Passos para Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/FelippeMenezes/sports-management.git
    cd sports-management
    ```

2.  **Instale as dependências:**
    ```bash
    bundle install
    ```

3.  **Configure o banco de dados:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Inicie o servidor local:**
    ```bash
    rails server
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
