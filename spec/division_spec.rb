require "spec_helper"

describe(Division) do

  it('tells what divisions are attached to a employee') do
    division = Division.create({name: "R&D"})
    employee = Employee.create({name: "Jim", division_id: division.id})
    expect(division.employees).to eq([employee])
  end

end
