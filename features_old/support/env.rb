require 'spork'

Spork.prefork do
  require 'cucumber/rails'
  require 'rspec/rails'

  require 'factory_girl'
	Dir.glob(File.join(File.dirname(__FILE__), '../../spec/factories/*.rb')).each {|f| require f }

  
  Capybara.default_selector = :css
  ActionController::Base.allow_rescue = false
  ENV["RAILS_ENV"] ||= 'test'
  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  I18n.backend.load_translations
end