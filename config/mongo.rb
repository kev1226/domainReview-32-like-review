require 'mongo'
require 'dotenv/load'

Mongo::Logger.logger.level = ::Logger::FATAL

DB = Mongo::Client.new(["#{ENV['MONGO_HOST']}:#{ENV['MONGO_PORT']}"], database: ENV['MONGO_DB'])
VOTES = DB[:votes]
