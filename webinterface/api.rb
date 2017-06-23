require 'sinatra'
require 'yaml'
require 'oauth2'
require 'open-uri'
require 'net/http'
require 'uri'

enable :sessions

@path = File.expand_path(File.dirname(__FILE__))
Settings = YAML.load_file(@path + '/../config.yml')

# Scopes are space separated strings
SCOPES = [
  'identify',
  'email'
].join(' ')

unless API_CLIENT = Settings['discord']['client_id']
  raise 'You must specify the G_API_CLIENT env variable'
end

unless API_SECRET = Settings['discord']['secret']
  raise 'You must specify the G_API_SECRET env veriable'
end

unless API_SITE = Settings['oauth2']['site']
  raise "You must have site, we can't send requests into air"
end

unless API_AUTHORIZE_URL = Settings['oauth2']['authorize']
  raise 'You must specify authorize URL for application'
end

unless API_TOKEN_URL = Settings['oauth2']['token']
  raise 'You must specify oauth2 token'
end

def client
  client ||= OAuth2::Client.new(
    API_CLIENT,
    API_SECRET,
    site: API_SITE,
    authorize_url: API_AUTHORIZE_URL,
    token_url: API_TOKEN_URL
  )
end

def send_request(method, url, params, body = '') 
  uri = URI.parse(url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request.add_field("Authorization", "Bearer #{session[:access_token]}")
  response = https.request(request)
  response.body
end

get '/' do
  @token = session[:access_token]
  unless @token.nil?
      @user_data = send_request(
        :get,
        "#{API_SITE}/api/users/@me",
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
  # erb :login
  redirect '/'
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/oauth2callback'
  uri.query = nil
  uri.to_s
end

