require 'yaml'
require 'oauth2'
require 'open-uri'
require 'net/http'
require 'uri'
require 'sinatra/base'

require_relative '../config'
require_relative './login.rb'

Login.run!
# puts Login.new