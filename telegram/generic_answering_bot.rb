require './generic_bot'

class GenericAnsweringBot < GenericBot
	def initialize(bot)
		super
		@messages_and_responses = { }
	end

	def add_command_and_response(command, response)
		@messages_and_responses.merge!({ command.to_sym => response })
	end

	def respond(message, chat)
		command, args = parse_message(message)
		response = get_response(command, args)
		send_message(chat, response) unless response.empty?
	end

	private

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
