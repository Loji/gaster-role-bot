require 'yaml'

@path = File.expand_path(File.dirname(__FILE__))
SettingsLoader = YAML.load_file(@path + "../../config.yml")

class Settings 
    class << self
        def discord_client_id
            unless client_id = SettingsLoader['discord']['client_id']
                raise 'You must specify the API Client'
            end
            client_id
        end

        def discord_secret 
            unless secret = SettingsLoader['discord']['secret']
                raise 'You must specify the API Secret'
            end
            secret
        end

        def oauth_site 
            unless site = SettingsLoader['oauth2']['site']
                raise "You must have site, we can't send requests into air"
            end
            site
        end

        def oauth_authorize_url 
            unless api_authorize_url = SettingsLoader['oauth2']['authorize']
                raise 'You must specify authorize URL for application'
            end
            api_authorize_url
        end

        def oauth_token 
            unless api_token_url = SettingsLoader['oauth2']['token']
                raise 'You must specify oauth2 token'
            end
            api_token_url
        end

        def oauth_revoke_url
            unless api_revoke_url = SettingsLoader['oauth2']['revoke']
                raise 'You must specify oauth2 revoke url'
            end
            api_revoke_url
        end

        def db_addr
            unless db = SettingsLoader['db']
                raise 'You must specify handle for db'
            end
            db
        end
    end
end 


