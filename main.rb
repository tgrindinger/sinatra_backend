# encoding: UTF-8
require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'

DataMapper::Property::String.length(255)
DataMapper::Model..raise_on_save_failure = true

configure :development do
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
end 

require './models/init' 
require './routes/init'

DataMapper.finalize
