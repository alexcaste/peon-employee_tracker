require "spec_helper"

describe(Employee) do

  it('tells what employees are attached to a division') do
    division = Division.create({name: "R&D"})
    employee1 = Employee.create({name: "Jim", division_id: division.id})
    employee2 = Employee.create({name: "Bob", division_id: division.id})
    expect(division.employees).to eq([employee1, employee2])
  end
  
end
