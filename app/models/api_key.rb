class ApiKey < ApplicationRecord
	before_create :generate_access_token

	private

	def generate_access_token
		begin
			#gerar o token
			self.access_token = SecureRandom.hex
			#se for repetido, não criar um novo
		end while self.class.exists?(access_token: access_token)
	end
end
