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

bot.addCommandAndResponse('/start', "Hi! I'm a bot written in Ruby. To see the commands available, write /help")
bot.addCommandAndResponse('/help', help)
bot.addCommandAndResponse('/test', 'This is an automated message, obviously!')
bot.addCommandAndResponse('/random', random_int)

bot.listen()
