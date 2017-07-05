require 'pg'
require 'sequel'
require_relative '../app/helpers/settings'

DB = Sequel.connect(Settings.db_addr)

require_relative './init' # create tables if they don't exist
