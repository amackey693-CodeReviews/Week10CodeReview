require 'pry'

class Project 
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(project_to_compare)
    self.title == project_to_compare.title
  end

  def self.all
    all_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    all_projects.each do | project |
      title = project.fetch('title')
      id = project.fetch('id').to_i
      projects.push(Project.new({title: title, id: id}))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING ID;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({title: title, id: id})
  end

  def update(title)
    @title = title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{id}")
  end

  def volunteers
    Volunteer.find_by_project(@id)
  end
end

## stretch - add sort method & search method
