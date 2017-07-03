
module DiscordOauth2Helpers
  def create_client
    OAuth2::Client.new(
      Settings.discord_client_id,
      Settings.discord_secret,
      site: Settings.oauth_site,
      authorize_url: Settings.oauth_authorize_url,
      token_url: Settings.oauth_token
    )
  end

  def send_request(method, url, params = {}, body = '')
    uri = URI.parse(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request.add_field('Authorization', "Bearer #{session[:access_token]}")
    response = https.request(request)
    response.body
  end

  def servers 
    send_request(
      :get,
      "#{Settings.oauth_site}/api/users/@me/guilds",
    )
  end

  def user 
    send_request(
      :get,
      "#{Settings.oauth_site}/api/users/@me"
    )
  end
end