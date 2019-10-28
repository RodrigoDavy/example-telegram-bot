require './bot'

token = ARGV[0] || ''

bot = Bot.new(token)

random_int = lambda do |args|
	args.map!(&:to_i).sort!().reverse!()

	final = args[0] || 10
	initial = args[1] || 0

	(rand(final - initial + 1) + initial).to_i().to_s()
end

help = "Available commands:
	/start - Welcome message
	/help - Shows this message
	/test - Just a test message
	/random - gives you a random number. You can pass up to two numbers as arguments"

bot.add_command_and_response('/start', "Hi! I'm a bot written in Ruby. To see the commands available, write /help")
bot.add_command_and_response('/help', help)
bot.add_command_and_response('/test', 'This is an automated message, obviously!')
bot.add_command_and_response('/random', random_int)

bot.listen()
