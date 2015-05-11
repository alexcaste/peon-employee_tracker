require('capybara/rspec')
require('./app')
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions,false)

describe("the employee list path", :type => :feature) do
  it("allows the user to see a list of all employees in the database") do
      Employee.create(name: "Harry")
      visit('/')
      click_link("List of Employees")
      expect(page).to have_content("Harry")
  end
end

describe("the division list path", :type => :feature) do
  it("allows the user to see a list of all divisions in the database") do
    Division.create(name: "R&D")
    visit('/')
    click_link("List of Divisions")
    expect(page).to have_content("R&D")
  end
end

describe("the division add path", :type => :feature) do
  it("allows the user to add a division to the database") do
    visit('/divisions/new')
    fill_in('name', :with => "R&D")
    click_button("Add")
    expect(page).to have_content("R&D")
  end
end

describe("the employee add path", :type => :feature) do
  it("allows the user to add an employee to the database") do
    visit('/employees/new')
    fill_in('name', :with => "Harry")
    click_button("Add")
    expect(page).to have_content("Harry")
  end
end

describe("the employee add path", :type => :feature) do
  it("allows the user to add an employee to the database") do
    Employee.create(name: "Harry")
    visit('/employees')
    click_link('Harry')
    expect(page).to have_content("Details for Harry")
  end
end
