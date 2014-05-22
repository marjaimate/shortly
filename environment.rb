$:.unshift File.dirname(__FILE__)
env = (ENV['RACK_ENV'] || :development)

require 'bundler'
Bundler.require :default, env.to_sym
require 'erb'

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  config.root     = File.dirname(__FILE__)
  config.env      = ActiveSupport::StringInquirer.new(env.to_s)
end

specific_environment = "config/environments/#{Application.config.env}.rb"
require specific_environment if File.exists? specific_environment
Dir["config/initializers/**/*.rb"].each {|f| require f}

