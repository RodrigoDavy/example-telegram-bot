require 'telegram/bot'
require './telegram/generic_answering_bot'

@token = ARGV[0] || ''

def run
	bot = GenericAnsweringBot.new(Telegram::Bot::Client.new(@token))

	set_strings()
	set_methods()

	bot.add_command_and_response('/start', @start)
	bot.add_command_and_response('/help', @help)
	bot.add_command_and_response('test', @test)
	bot.add_command_and_response('/random', @random_int)

	bot.listen { |chat, message| bot.respond(chat, message) }
end

def set_strings
	@start = "Hi! I'm a bot written in Ruby. To see the commands available, write /help"

	@help = "Available commands:
		--------------------------
		/start - Welcome message
		/help - Shows this message
		/random - gives you a random number. You can pass up to two numbers as arguments

		P.S.: You can also type a message containing the word 'test', if you want"

	@test = "Yay, this bot can detect the word 'test' in any position in the message!"
end

def set_methods
	@random_int = lambda do |args|
		args.map!(&:to_i).sort!().reverse!()

		final = args[0] || 10
		initial = args[1] || 0

		(rand(final - initial + 1) + initial).to_i().to_s()
	end
end

run()
