class LoginController < ApplicationController
  SCOPES = [
    'identify',
    'email',
    'guilds'
  ].join(' ')

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/login/oauth2callback'
    uri.query = nil
    uri.to_s
  end

  get '/' do
    @deb = get_user_id '166914789451235328'

    erb :login
  end

  get '/auth' do
    redirect @client.auth_code.authorize_url(
      redirect_uri: redirect_uri,
      scope: SCOPES
    )
  end

  get '/oauth2callback' do
    access_token = @client.auth_code.get_token(
      params[:code],
      redirect_uri: redirect_uri
    )
    session[:access_token] = access_token.token
    redirect '/'
  end
end
