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

describe("the employee details path", :type => :feature) do
  it("allows the user to see the details and options for an emplpoyee") do
    Employee.create(name: "Harry")
    visit('/employees')
    click_link('Harry')
    expect(page).to have_content("Details for Harry")
  end
end

describe("the divisions detail path", :type => :feature) do
  it("allows the user to see the details and options for a division") do
    Division.create(name: "Death Star")
    visit('/divisions')
    click_link('Death Star')
    expect(page).to have_content("Details for Death Star")
  end
end

describe("the rename employee path", :type => :feature) do
  it("allows the user to rename a employee") do
    Employee.create(name: "Admiral Ozzel")
    visit('/employees')
    click_link('Admiral Ozzel')
    fill_in('name', :with => "Admiral Piett")
    click_button('Update')
    expect(page).to have_content("Details for Admiral Piett")
  end
end

describe("the rename division path", :type => :feature) do
  it("allows the user to rename a division") do
    Division.create(name: "Death Star")
    visit('/divisions')
    click_link('Death Star')
    fill_in('name', :with => "Death Star II")
    click_button('Update')
    expect(page).to have_content("Details for Death Star II")
  end
end

describe("the delete employee path", :type => :feature) do
  it("allows the user to delete an employee") do
    Employee.create(name: "Admiral Ozzel")
    Employee.create(name: "Admiral Piett")
    visit('/employees')
    click_link("Admiral Ozzel")
    click_button("Delete")
    expect(page).to have_content("Admiral Piett")
  end
end

describe("the delete division path", :type => :feature) do
  it("allows the user to delete a division") do
    Division.create(name: "Alderaan")
    Division.create(name: "Death Star")
    visit('/divisions')
    click_link("Alderaan")
    click_button("Delete")
    expect(page).to have_content("Death Star")
  end
end

describe("the adding an employee to a division path", :type => :feature) do
  it("allows the user to add an employee to a division") do
    Employee.create(name: "Yoda")
    Division.create(name: "Dagobah")
    visit('/divisions')
    click_link("Dagobah")
    select("Yoda")
    click_button("Assign")
    expect(page).to have_content("Yoda")
  end
end

describe("the adding a division to an employee path", :type => :feature) do
  it("allows the user to add a division to an employee") do
    Employee.create(name: "Anakin")
    Division.create(name: "Sith")
    visit('/employees')
    click_link("Anakin")
    select("Sith")
    click_button("Assign")
    expect(page).to have_content("Sith")
  end
end

describe("the project list path", :type => :feature) do
  it("allows the user to see a list of all projects in the database") do
    Project.create(name: "Destroy the Rebel Alliance")
    visit('/')
    click_link("List of Projects")
    expect(page).to have_content("Destroy the Rebel Alliance")
  end
end
