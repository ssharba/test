source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'pry-rails'
gem 'rails', '~> 5.0.6'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sidekiq'
gem 'active_model_serializers'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
