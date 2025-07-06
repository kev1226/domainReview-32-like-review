require 'sinatra'
require 'dotenv/load'
require_relative 'config/mongo'
require_relative 'app/routes'

set :port, ENV['PORT']
set :bind, '0.0.0.0'
