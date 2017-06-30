require 'yaml'
require 'oauth2'
require 'open-uri'
require 'net/http'
require 'uri'
require 'sinatra/base'

require_relative './app/helpers/settings'
require_relative './login.rb'

map '/' do 
  run Login
end

