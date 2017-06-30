require 'sequel'
require_relative '../config'

DB = Sequel.connect(Settings['db'])

require_relative './init' # create tables if they don't exist
