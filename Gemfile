source "https://rubygems.org"

# Versão do Ruby baseada no sistema atual
ruby "3.1.4"

# Rails Core
gem "rails", "~> 7.1.5"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# Assets & Frontend (Padrão Rails 7)
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# --- UI & Utilities ---
gem "bootstrap", "~> 5.3"
gem "sassc-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form", github: "heartcombo/simple_form"
gem "autoprefixer-rails"
gem "devise"
gem "pundit"
gem "faker"

# Variáveis de ambiente
gem "dotenv-rails", groups: [:development, :test]

# Background processing
gem 'sidekiq'
gem 'sidekiq-status'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "pry-byebug"
  gem "pry-rails"
end

group :development do
  gem "web-console"
  gem "listen", "~> 3.3"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
end

# Testing framework and factories
group :development, :test do
  gem "rspec-rails", "~> 6.1.0"
  gem "factory_bot_rails"
end

group :production do
  gem "rails_serve_static_assets"
end
