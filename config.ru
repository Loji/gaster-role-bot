require 'bundler'
Bundler.require

require_all 'app'

# Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

map('/example') { run TestingController }
map('/') { run LoginController }
