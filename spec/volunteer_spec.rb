require "spec_helper"

describe Volunteer do
  context '#initialize' do
    it 'returns the name of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end

    it 'returns the project_id of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe '#==' do
    it 'checks for equality based on the name of a volunteer' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Volunteer.all).to eq []
    end

    it 'returns all volunteers' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe '#save' do
    it 'adds a volunteer to the database' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end

  describe '.find' do
    it 'returns a volunteer by id' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to eq volunteer1
    end
  end

  describe 'project' do
    it 'returns a project by project_id' do
      project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project1.save
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => project1.id, :id => nil})
      volunteer1.save
      expect(volunteer1.project).to eq project1
    end
  end

  describe '.find_by_project' do
    it 'finds volunteers on a specific project ' do
      project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project1.save
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => project1.id, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => project1.id, :id => nil})
      volunteer2.save
      volunteer3 = Volunteer.new({:name => 'Jane', :project_id => project1.id, :id => nil})
      volunteer3.save
      expect(Volunteer.find_by_project(project1.id)).to eq [volunteer1, volunteer2, volunteer3]
    end
  end

  describe '#delete' do
    it 'allows an ADMIN to delete a volunteer' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 2, :id => nil})
      volunteer1.save
      volunteer1.delete
      expect(Project.all).to eq []
    end
  end

  context '#update' do
    it 'allows an ADMIN to update a volunteers name & reassign the project ID if needed' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 2, :id => nil})
      volunteer1.save
      volunteer1.update("Jill", 2)
      volunteer2 = Volunteer.new({:name => 'Alex', :project_id => 2, :id => nil})
      volunteer2.save
      volunteer2.update("Alex", 4)
      expect(volunteer1.name).to eq "Jill"
      expect(volunteer2.project_id).to eq 4
    end

  end

end
 

  

  




