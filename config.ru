require 'bundler'
Bundler.require

require_all 'app'

map('/login') { run LoginController }
map('/') { run IndexController }
