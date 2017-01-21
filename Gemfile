source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails' # Rails
gem 'sqlite3' # Active Record database
gem 'puma', '~> 3.0' # Web server
gem 'sass-rails', '~> 5.0' # SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Asset compressor
gem 'coffee-rails', '~> 4.2' # CoffeeScript
gem 'turbolinks', '~> 5' # Turbolinks
gem 'redis' # Volatile memory database

gem 'actioncable' # Rails socket implementation

gem 'jquery-rails' #JQuery

gem 'bcrypt-ruby', :require => 'bcrypt' # For hashing passwords

group :development, :test do
  gem 'byebug', platform: :mri # Debug tool
  gem 'rails-controller-testing' # Provides controller testing methods
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # For Windows support
