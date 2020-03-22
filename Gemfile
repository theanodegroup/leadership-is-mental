source 'https://rubygems.org'

ruby '2.3.0'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.1'
# Use postgres as the database for Active Record
gem "pg", "~> 0.18"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Monitoring
gem 'newrelic_rpm'
gem 'rails_autoscale_agent'

# Styling
gem "twitter-bootstrap-rails"
gem "gretel" # Breadcrumbs
gem 'kaminari' # Pagination
gem 'social-share-button'

# User Management
gem 'devise', ">= 4.7.1"

# CMS
gem "phrasing", '~> 4.1.0'
gem 'quilljs-rails'
gem 'carrierwave', '~> 1.0'
gem 'cloudinary' # Store uploaded Files users can download

# Validations
gem 'phonelib'
gem "recaptcha", require: "recaptcha/rails"

gem 'sitemap_generator'

# URLs
gem 'bitly', '2.0.0.beta.1'

# Courses
gem 'vhx-ruby', :git => 'https://github.com/vhx/vhx-ruby'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'gemsurance'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Heroku
gem 'rails_12factor', group: :production

# Security updates
gem "rake", ">= 12.3.3"
gem "rack", ">= 1.6.12"
gem "loofah", ">= 2.3.1"
