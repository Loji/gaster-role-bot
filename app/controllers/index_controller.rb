
class IndexController < ApplicationController
  get '/' do
    @servers = servers
    
    erb :index
  end
end
