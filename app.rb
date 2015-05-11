require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/division"
require "./lib/employee"
require "./lib/project"

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

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/divisions/new') do

  erb(:division_form)
end

get('/employees/new') do

  erb(:employee_form)
end

get('/projects/new') do

  erb(:project_form)
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

post('/projects/new') do
  Project.create(name: (params.fetch("name")))
  @projects = Project.all()
  erb(:projects)
end

get('/employees/:id') do
  @divisions = Division.all
  @employee = Employee.find(params.fetch("id"))
  erb(:employee)
end

get('/divisions/:id') do
  @division = Division.find(params.fetch("id"))
  @all_employees = Employee.all
  @employees = @division.employees
  erb(:division)
end

get('/projects/:id') do
  @all_employees = Employee.all
  @project = Project.find(params.fetch("id"))
  @employees = @project.employees
  erb(:project)
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

patch('/projects/:id/update') do
  @project = Project.find(params.fetch("id"))
  @project.update({name: params.fetch("name")})
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

patch('/projects/:id/assign') do
  project_id = params.fetch("id")
  @project = Project.find(project_id)
  employee_id = params.fetch("employee")
  employee = Employee.find(employee_id)
  employee.update(project_id: project_id)
  @all_employees = Employee.all
  @employees = @project.employees
  erb(:project)
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

delete('/projects/:id/delete') do
  project = params.fetch("id").to_i
  @project = Project.find(project)
  @project.delete
  @projects = Project.all
  erb(:projects)
end
