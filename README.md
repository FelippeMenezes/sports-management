Sports Management

A sports management simulation built with Ruby on Rails, designed to generate and manage football campaigns. This project uses Sidekiq and Redis to handle long-running operations in the background, ensuring a smooth and responsive user experience.

✨ Features
Core Functionality

User Authentication: Full sign-up and login system powered by Devise.

Campaign Creation: Generates a main team for the user along with multiple AI-controlled rival teams.

Automatic Player Generation: Each team is populated with random players with distinct positions and skill levels.

Background Job Processing: Campaign creation runs as a background job using Sidekiq to avoid UI freezing.

Real-Time Progress Tracking: Users can follow the creation progress through a dynamic progress bar updated via StimulusJS and Sidekiq-Status.

Access Control: Business-rule-based authorization with Pundit.

🚀 Tech Stack
Backend

Ruby: 3.1.4

Rails: ~> 7.1.5

Database: PostgreSQL

Web Server: Puma

Background Jobs: Sidekiq

Job Queue: Redis

Job Monitoring: Sidekiq-Status

Authentication: Devise

Authorization: Pundit

Frontend

Hotwire: Turbo & Stimulus

Package Management: Importmap

CSS Framework: Bootstrap ~> 5.3 (with Sass via sassc-rails)

Icons: Font Awesome

Forms: Simple Form

Development & Testing

Environment Variables: dotenv-rails

Debugging: debug, pry-byebug, pry-rails

Testing Tools: RSpec, Factory Bot

⚙️ Local Setup
Prerequisites

Ruby 3.1.4

Bundler

PostgreSQL running locally

Redis running locally

Installation

Clone the repository

git clone https://github.com/FelippeMenezes/sports-management.git
cd sports-management


Install dependencies

bundle install


Set up the database

rails db:create
rails db:migrate


Start the services

Open three terminals:

Terminal 1 – Redis

redis-server


(Skip if Redis is already running as a system service.)

Terminal 2 – Sidekiq

bundle exec sidekiq


Terminal 3 – Rails Server

rails s

Access the App

Visit:

http://localhost:3000

