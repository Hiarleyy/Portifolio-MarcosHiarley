source "https://rubygems.org"

ruby ">= 3.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.6"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Authentication
gem "devise", "~> 4.9"

# Image processing for Active Storage variants
gem "image_processing", "~> 1.2"

# Pagination
gem "kaminari", "~> 1.2"

# Friendly URLs
gem "friendly_id", "~> 5.5"

# Markdown rendering
gem "redcarpet", "~> 3.6"

# Syntax highlighting for code blocks
gem "rouge", "~> 4.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Windows/JRuby timezone data (required on Windows with Ruby 4.x)
gem "tzinfo-data"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  # Load .env variables automatically
  gem "dotenv-rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end
