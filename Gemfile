source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails' # Rails
gem 'puma', '~> 3.0' # Web server
gem 'sass-rails', '~> 5.0' # SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Asset compressor
gem 'coffee-rails', '~> 4.2' # CoffeeScript
gem 'turbolinks', '~> 5' # Turbolinks
gem 'redis' # Volatile memory database

gem 'actioncable' # Rails socket implementation

gem 'jquery-rails' #JQuery

gem 'bcrypt-ruby', :require => 'bcrypt' # For hashing passwords

gem "fog-aws" # S3 integration
gem 'carrierwave', '~> 1.0' # File upload management

gem 'remotipart', '~> 1.2' # For AJAX file uploads

group :production do
  gem 'rails_12factor'
  gem 'pg' # Production database
end

group :development, :test do
  gem 'byebug', platform: :mri # Debug tool
  gem 'rails-controller-testing' # Provides controller testing methods
  gem 'sqlite3' # Active Record database
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # For Windows support
