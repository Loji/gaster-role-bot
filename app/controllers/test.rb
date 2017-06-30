class Testing < Sinatra::Base
  configure do
    set :sessions, true
  end

  get '/test' do
    puts 'hello'
    session[:test] = 'super coś tu jest'
  end
end
