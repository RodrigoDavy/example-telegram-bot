require './telegram/generic_bot'

class GenericAnsweringBot < GenericBot
	def initialize(bot)
		super
		@messages_and_responses = { }
	end

	def add_command_and_response(command, response)
		@messages_and_responses.merge!({ command => response })
	end

	def respond(chat, message)
		command, args = get_command_args(message)
		response = get_response(command, args)
		send_message(chat, response) unless response.empty?
	end

	private

	def get_command_args(message)
		args, key_pos = parse_message(message)
		command = args[key_pos] if key_pos.is_a?(Integer)
		args.shift if key_pos == 0 #the first argument corresponding to a /command is ignored
		return command, args
	end

	def get_response(key, args = [])
		return "" unless @messages_and_responses.has_key?(key)
		return @messages_and_responses[key].(args).to_s if @messages_and_responses[key].is_a?(Proc)
		@messages_and_responses[key].to_s
	end

	def parse_message(message)
		words = message.split(" ")
		key_pos = get_command_index(words)
		return words, key_pos
	end

	def get_command_index(words)
		return 0 if words[0][0] == '/'
		non_slash_commands().each() do |command|
			return words.index(command) unless words.index(command).nil?
		end
	end

	def non_slash_commands()
		@messages_and_responses.select { |m| !m.include?("/") }.keys()
	end
end
