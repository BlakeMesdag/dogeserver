source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'pg'

gem 'httparty'

group :development do
  gem 'thin'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-plus'
  gem 'fakeredis'
end

group :test do
  gem 'fakeweb', '~> 1.3'
end

group :production do
  gem 'rails_12factor'
  gem 'unicorn'
end
