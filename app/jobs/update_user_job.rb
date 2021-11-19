# Job assíncrono para criar o moustache
class UpdateUserJob < ApplicationJob
	queue_as :default

	def perform(user)
		user.update(last_name: "#{user.last_name} 🥸")
	end
end