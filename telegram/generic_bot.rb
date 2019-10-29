class GenericBot
	def initialize(bot)
		@bot = bot
	end

	def send_message(chat_id, text)
		@bot.api.send_message(chat_id: chat_id, text: text)
		puts 'Message sent to ' + chat_id.to_s
	end

	def listen
		@bot.listen { |message| yield(message.chat.id, message.to_s) }
	end
end
