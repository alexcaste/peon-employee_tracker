require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/division"
require "./lib/employee"

get('/') do
  erb(:index)
end

get('/divisions') do
  @divisions = Division.all()
  erb(:divisions)
end

get('/employees') do
  @employees = Employee.all()
  erb(:employees)
end

get('/divisions/new') do

  erb(:division_form)
end

get('/employees/new') do

  erb(:employee_form)
end

post('/employees/new') do
  Employee.create(name: (params.fetch("name")))
  @employees = Employee.all()
  erb(:employees)
end

post('/divisions/new') do
  Division.create(name: (params.fetch("name")))
  @divisions = Division.all()
  erb(:divisions)
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch("id"))
  erb(:employee)
end

get('/divisions/:id') do
  @division = Division.find(params.fetch("id"))
  @all_employees = Employee.all
  @employees = @division.employees
  erb(:division)
end

patch('/employees/:id/update') do
  @employee = Employee.find(params.fetch("id"))
  @employee.update({name: params.fetch("name")})
  erb(:employee)
end

patch('/employees/:id/assign') do
  @employee = Employee.find(params.fetch("id"))
  @employee.update({division_id: params.fetch("division")})
  erb(:employee)
end

patch('/divisions/:id/update') do
  @division = Division.find(params.fetch("id"))
  @division.update({name: params.fetch("name")})
  erb(:division)
end

patch('/divisions/:id/assign') do
  division_id = params.fetch("id")
  @division = Division.find(division_id)
  employee_id = params.fetch("employee")
  employee = Employee.find(employee_id)
  employee.update(division_id: division_id)
  @all_employees = Employee.all
  @employees = @division.employees
  erb(:division)
end

delete('/employees/:id/delete') do
  employee_id = params.fetch("employee_id").to_i
  @employee = Employee.find(employee_id)
  @employee.delete
  @employees = Employee.all
  erb(:employees)
end

delete('/divisions/:id/delete') do
  division = params.fetch("id").to_i
  @division = Division.find(division)
  @division.delete
  @divisions = Division.all
  erb(:divisions)
end
