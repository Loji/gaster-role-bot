class ApplicationController < Sinatra::Base
  helpers DiscordOauth2Helpers

  set :views, File.expand_path('../../views', __FILE__)

  configure :production, :development do
    enable :logging
    enable :sessions
  end

  before do
    pass if ['login'].include? request.env['REQUEST_PATH'].split('/')[1]
    redirect '/login' unless session[:access_token]
  end

  def initialize
    super
    @client ||= create_client
  end
end
