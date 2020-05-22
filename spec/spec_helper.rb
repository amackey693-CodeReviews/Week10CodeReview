require 'rspec'
require 'pg'
require '#'
require '#'
require 'pry'

DB = PG.connect({:dbname => ''}) 


RSpec.configure do |config|
  config.after(:each) do  
    DB.exec("DELETE FROM  *;")
    DB.exec("DELETE FROM  *;")
  end
end