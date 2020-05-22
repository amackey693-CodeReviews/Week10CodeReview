require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require('pg')
DB = PG.connect({:dbname => 'volunteer_tracker'})
also_reload('lib/**/*.rb')

get('/terminate') do
  exit # system exit!
end

puts "This is process #{Process.pid}"

get('/')do
  @projects = Project.all
  erb(:home) 
end

get('/home')do
  @projects = Project.all
  erb(:home)
end

post('/project')do
  new_project = Project.new({title: params[:title], id: nil})
  new_project.save
  redirect to('/home')
end

get('/home/:id')do
  @project = Project.find(params[:id].to_i())
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


# get('/volunteers')do
#   @volunteers = Volunteer.all
#   erb(:volunteers)
# end

# post('/volunteers')do
#   full_name = params[:first_name] + " " + params[:last_name]
#   phone_number = params[:phone_number]
#   email = params[:email]
#   user_name = params[:user_name]
#   password = params[:password]
#   new_volunteer = Volunteer.new({name: full_name, project_id: nil, id: nil})
#   new_volunteer.save()

#   erb(:thank_you)
# end




# EXAMPLES FOR GET, POST, PATCH & DELETE
# get('/') do
#   @albums = Album.sort
#   erb(:albums) #erb file name
# end

# post('/albums') do ## Adds album to list of albums, cannot access in URL bar
#   name = params[:album_name]
#   artist = params[:album_artist]
#   year = params[:album_year]
#   genre = params[:album_genre]
#   song = params[:song_id]
#   in_inventory = params[:in_inventory]
#   album = Album.new(name, nil, artist, genre, year)
#   album.save()
#   redirect to('/albums')
# end

# patch('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   @albums = Album.all
#   if params[:buy]
#     @album.sold()
#   else  
#     @album.update(params[:name])
#   end
#   erb(:albums)
# end

# delete('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   @album.delete()
#   redirect to('/albums')
# end