require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require('pg')
DB = PG.connect({:dbname => 'volunteer_tracker'})
also_reload('lib/**/*.rb')


get('/')do
  @projects = Project.all
  erb(:home) 
end

get('/home')do
  @projects = Project.all
  erb(:home)
end

post('/project/new')do
  new_project = Project.new({title: params[:title], id: nil})
  new_project.save
  redirect to('/home')
end

get('/home/:id')do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all
  erb(:project)
end

get('/edit/:id')do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch('/edit/:id')do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:title])
  erb(:project)
end

delete('/delete/:id')do
  @project = Project.find(params[:id].to_i())
  @project.delete
  redirect to('/home')
end

post('/project/:id/volunteers')do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all
  full_name = params[:first_name] + " " + params[:last_name]
  new_volunteer = Volunteer.new({name: full_name, project_id: @project.id, id: nil})
  new_volunteer.save
  erb(:project)
end



