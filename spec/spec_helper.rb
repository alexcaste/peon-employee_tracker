ENV['RACK_ENV'] = 'test'

require "rspec"
require "sinatra/activerecord"
require "division"
require "employee"
require "project"
require "pry"
require "pg"



RSpec.configure do |config|
  config.after(:each) do
    Employee.all().each() do |employee|
      employee.destroy
    end
    Division.all().each() do |division|
      division.destroy
    end
  end
end
