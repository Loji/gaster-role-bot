require 'yaml'

@path = File.expand_path(File.dirname(__FILE__))
SettingsLoader = YAML.load_file(@path + "/config.yml")

class Settings 
    class << self
        def discord_token 
            unless TOKEN = SettingsLoader['discord']['client_id']
                raise 'You must specify the G_API_CLIENT env variable'
            end
            TOKEN
        end

        def discord_client_id
            unless CLIENT_ID = SettingsLoader['discord']['client_id']
                raise 'You must specify the G_API_CLIENT env variable'
            end
            CLIENT_ID
        end

        def discord_secret 
            unless SECRET = SettingsLoader['discord']['secret']
                raise 'You must specify the G_API_SECRET env veriable'
            end
            SECRET
        end

        def oauth_site 
            unless SITE = SettingsLoader['oauth2']['site']
                raise "You must have site, we can't send requests into air"
            end
            SITE
        end

        def oauth_authorize_url 
            unless API_AUTHORIZE_URL = SettingsLoader['oauth2']['authorize']
                raise 'You must specify authorize URL for application'
            end
            API_AUTHORIZE_URL
        end

        def oauth_token 
            unless API_TOKEN_URL = SettingsLoader['oauth2']['token']
                raise 'You must specify oauth2 token'
            end
            API_TOKEN_URL
        end

        def oauth_revoke_url
            unless API_REVOKE_URL = SettingsLoader['oauth2']['revoke']
                raise 'You must specify oauth2 revoke url'
            end
            API_REVOKE_URL
        end

        def db_addr
            unless DB = SettingsLoader['db']
                raise 'You must specify handle for db'
            end
            DB
        end
    end
end 


