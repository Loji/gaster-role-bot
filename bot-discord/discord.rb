require 'discordrb'
require 'yaml'

@path = File.expand_path(File.dirname(__FILE__))
Settings = YAML.load_file(@path + "/../config.yml")

bot = Discordrb::Bot.new(
    token: Settings['discord']['token'], 
    client_id: Settings['discord']['client_id']
)

bot.message(with_text: 'Ping!') do |event|
    event.respond 'Pong!'
end

bot.message(with_text: 'help') do |event| 
    event.respond 'I\'ll help but now I do potatoe'
end

bot.run