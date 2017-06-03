require 'sinatra'
require 'yaml'
require 'oauth2'

enable :sessions
 
@path = File.expand_path(File.dirname(__FILE__))
Settings = YAML.load_file(@path + "/../config.yml")

# Scopes are space separated strings
SCOPES = [
    #'https://www.googleapis.com/auth/userinfo.email'
    'email'
].join(' ')
 
unless API_CLIENT = Settings['discord']['client_id']
  raise "You must specify the G_API_CLIENT env variable"
end
 
unless API_SECRET = Settings['discord']['secret']
  raise "You must specify the G_API_SECRET env veriable"
end

unless API_SITE = Settings['oauth2']['site'] 
  raise "You must have site, we can't send requests into air"
end

unless API_AUTHORIZE_URL = Settings['oauth2']['authorize']
  raise "a"
end

unless API_TOKEN_URL = Settings['oauth2']['token']
  raise "b"
end


def client
  client ||= OAuth2::Client.new(API_CLIENT, API_SECRET, {
                :site => API_SITE, 
                :authorize_url => API_AUTHORIZE_URL, 
                :token_url => API_TOKEN_URL
              })
end
 
get '/' do
  erb :index
end
 
get "/auth" do
  redirect client.auth_code.authorize_url(
    :redirect_uri => redirect_uri,
    :scope => SCOPES,
    #:access_type => "offline"
  )
end
 
get '/oauth2callback' do
  access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
  session[:access_token] = access_token.token
  @message = "Successfully authenticated with the server"
  @access_token = session[:access_token]
  puts access_token
  @email = access_token.get('email').parsed
  erb :loginSuccess
end
 
def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/oauth2callback'
  uri.query = nil
  uri.to_s
end
