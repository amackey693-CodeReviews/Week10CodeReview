require 'pry'

class Volunteer 
  attr_accessor :name, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(volunteer_to_compare)
    self.name == volunteer_to_compare.name
  end

  def self.all 
    all_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    all_volunteers.each do | volunteer |
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({name: name, project_id: project_id, id: id}))
    end
    volunteers
  end
  
end

