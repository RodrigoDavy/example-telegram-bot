require 'telegram/bot'
require './telegram/generic_answering_bot'

@token = ARGV[0] || ''

def run
	bot = GenericAnsweringBot.new(Telegram::Bot::Client.new(@token))

	set_strings()
	set_methods()

	bot.add_command_and_response('/start', @start)
	bot.add_command_and_response('/help', @help)
	bot.add_command_and_response('/test', @test)
	bot.add_command_and_response('/random', @random_int)

	bot.listen { |message, chat| bot.respond(message, chat) }
end

def set_strings
	@start = "Hi! I'm a bot written in Ruby. To see the commands available, write /help"

	@help = "Available commands:
		--------------------------
		/start - Welcome message
		/help - Shows this message
		/test - Just a test message
		/random - gives you a random number. You can pass up to two numbers as arguments"

	@test = 'This is an automated message, obviously!'
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