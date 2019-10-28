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
		puts 'Mensaje enviado a ' + chat_id.to_s
	end

	def addCommandAndResponse(message, response)
		@messages_and_responses.merge!({ message.to_sym => response })
	end

	private

	def respond(message)
		response = getResponse(message)
		send_message(message.chat.id, response) unless response.empty?
	end

	def getResponse(message)
		args = message.to_s.split(" ")
		command = args.shift().to_sym
		response = ""

		if @messages_and_responses.has_key?(command)
			response = @messages_and_responses[command] if @messages_and_responses[command].is_a?(String)
			response = @messages_and_responses[command].(args) if @messages_and_responses[command].is_a?(Proc)
		end

		response
	end
end
