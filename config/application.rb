require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShareSpace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    ENV['AWS_ACCESS_KEY_ID'] = 'test'
    ENV['AWS_SECRET_ACCESS_KEY'] = 'test'

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    CarrierWave.configure do |config|
      config.fog_provider = 'fog/aws'
      config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region:                'us-west-1',
        endpoint:              'https://s3-us-west-1.amazonaws.com',
        path_style: true
      }
      config.fog_directory  = 'nwsharespace'
      config.fog_public     = false
      config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
      config.cache_dir = "#{Rails.root}/tmp/uploads"
    end
  end
end
