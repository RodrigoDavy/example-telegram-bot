require 'telegram/bot'

class Bot
	def initialize(token)
		@bot = Telegram::Bot::Client.new(token)
		@messages_and_responses = { }
	end

	def listen()
		@bot.listen { |message| respond(message) }
	end

	def send_message(chat_id, text)
		@bot.api.send_message(chat_id: chat_id, text: text)
		puts 'Message sent to ' + chat_id.to_s
	end

	def add_command_and_response(command, response)
		@messages_and_responses.merge!({ command.to_sym => response })
	end

	private

	def respond(message)
		command, args = parse_message(message.to_s)
		response = get_response(command, args)
		send_message(message.chat.id, response) unless response.empty?
	end

	def parse_message(message)
		args = message.split(" ")
		command = args.shift().to_sym
		return command, args
	end

	def get_response(key, args = [])
		return "" unless @messages_and_responses.has_key?(key)

		return @messages_and_responses[key].(args) if @messages_and_responses[key].is_a?(Proc)
		@messages_and_responses[key]
	end
end
