
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
    JSON.parse response.body
  end

  def server
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

  def get_user_id(user_id = user['id'])
    users = @DB[:users]
    current_user = users.where(discordId: user_id).first
    return current_user[:id] unless current_user.nil?
    users.insert discordId: user['id']
  end

  def get_server_id(server_id = server['id'])
    servers = @DB[:servers]
    current_server = servers.where(discordId: server_id).first
    return current_server[:id] unless current_server.nil?
    servers.insert discordId: server_id
  end
end
