#encoding=utf-8
require 'spork'


Spork.prefork do
  require 'rubygems'

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  require "authlogic/test_case"
  include Authlogic::TestCase

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  ENV['AUTOFEATURE'] = "true"
  ENV['RSPEC'] = "true"

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
  end

  FactoryGirl.find_definitions

  # Needed for Spork
  ActiveSupport::Dependencies.clear

  require 'capybara/rspec'

  def should_not_access
    it {response.should redirect_to "/login"}
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  I18n.backend.load_translations
end