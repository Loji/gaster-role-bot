class Login < Sinatra::Base
  SCOPES = [
    'identify',
    'email',
    'guilds'
  ].join(' ')

  def initialize
    super
    @client ||= client
  end

  configure do
    set :sessions, true
  end

  def client
    OAuth2::Client.new(
      Settings.discord_client_id,
      Settings.discord_secret,
      site: Settings.oauth_site,
      authorize_url: Settings.oauth_authorize_url,
      token_url: Settings.oauth_token
    )
  end

  def send_request(method, url, params, body = '')
    uri = URI.parse(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request.add_field('Authorization', "Bearer #{session[:access_token]}")
    response = https.request(request)
    response.body
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
  end

  get '/' do
    @token = session[:access_token]
    unless @token.nil?
      @user_data = send_request(
        :get,
        "#{Settings.oauth_site}/api/users/@me/guilds",
        params: {
          'Authorization' => "Bearer #{@token}"
        }
      )
    end
    erb :index
  end

  get '/auth' do
    redirect client.auth_code.authorize_url(
      redirect_uri: redirect_uri,
      scope: SCOPES
    )
  end

  get '/oauth2callback' do
    access_token = client.auth_code.get_token(
      params[:code],
      redirect_uri: redirect_uri
    )
    session[:access_token] = access_token.token
    redirect '/'
  end

  get '/test' do
    puts 'hello'
    session[:test] = 'super coś tu jest'
  end
end
