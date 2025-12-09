# Sports Management

This is a sports management project developed with Ruby on Rails, designed to simulate the creation and management of soccer campaigns. The application uses background processing with **Sidekiq** and **Redis** to provide a smooth user experience during time-consuming operations, such as creating a new campaign with multiple teams and players.

---

## ✨ Key Features

- **User Authentication:** Complete registration and login system with **Devise**.
- **Campaign Creation:** Generation of a team for the user and multiple rival teams controlled by the AI.
- **Automatic Player Generation:** Each team is populated with randomly generated players, with distinct positions and levels.
- **Background Processing:** Campaign creation, a heavy task, is executed as a background job with **Sidekiq**, preventing the user interface from freezing.
- **Real-time Progress Bar:** The user tracks the status of the campaign creation through a progress bar that is dynamically updated via **StimulusJS** and **Sidekiq-Status**.
- **Access Control:** Authorization based on business rules with **Pundit**.

---

## 🚀 Technologies Used

### Backend
- **Ruby:** `3.1.4`
- **Rails:** `~> 7.1.5`
- **Database:** PostgreSQL (`pg` gem)
- **Web Server:** Puma
- **Background Jobs:** Sidekiq
- **Job Queue:** Redis
- **Job Monitoring:** Sidekiq-Status
- **Authentication:** Devise
- **Authorization:** Pundit

### Frontend
- **JavaScript Framework:** Hotwire (Turbo and Stimulus)
 - **JS Package Manager:** Importmap
- **CSS Framework:** Bootstrap `~> 5.3` with Sass (`sassc-rails`)
- **Icons:** Font Awesome
- **Forms:** Simple Form

- **Development and Testing**
- **Environment Variables:** `dotenv-rails`
- **Debugging:** `debug`, `pry-byebug`, `pry-rails`
- **Testing:** RSpec and Factory Bot

---

## ⚙️ Local Environment Setup

### Prerequisites
- **Ruby** na versão `3.1.4`. Recomenda-se o uso de um gerenciador de versões como `rbenv` ou `asdf`.
- **Ruby** version `3.1.4`. It is recommended to use a version manager like `rbenv` or `asdf`.
- **Bundler**
- **PostgreSQL** installed and running.
- **Redis** installed and running.

### Installation Steps

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/FelippeMenezes/sports-management.git
    cd sports-management
    ```

2.  **Install Ruby dependencies:**
    ```bash
    bundle install
    ```

3.  **Set up the PostgreSQL database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Start the services in separate terminals:**

    For the application to work correctly, you need to start **three processes** in **three different terminals**:

    - **Terminal 1: Start Redis**
      _**Note:** If you installed Redis using `brew` (macOS) or `apt` (Linux) and configured it as a service that starts with the system, it should already be running in the background. In that case, you can skip this step and will only need two terminals._
      ```bash
      redis-server
      ```

    - **Terminal 2: Start the Sidekiq Worker** to process jobs:
      ```bash
      bundle exec sidekiq
      ```

    - **Terminal 3: Start the Rails server:**
    ```bash
    rails s
    ```

You can now access the application at `http://localhost:3000`.

---

## ☁️ Deployment

This project is configured for continuous deployment on the **Render.com** platform (free plan).

### Services Used
- **Web Service:** `Ruby` environment.
- **Database:** `PostgreSQL`.

### Configuration on Render
- **Build Command:** `./render-build.sh`
- **Start Command:** `bundle exec rails server`

### Required Environment Variables
The following environment variables must be configured in the Render web service:
- `DATABASE_URL`: Automatically provided by Render when connecting to the internal PostgreSQL service.
- `RAILS_MASTER_KEY`: Contents of the `config/master.key` file.
- `RAILS_SERVE_STATIC_FILES`: `true`

The `render-build.sh` script handles dependency installation, asset pre-compilation, and database migration on each deploy.
