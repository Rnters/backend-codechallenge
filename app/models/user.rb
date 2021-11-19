class User < ApplicationRecord
	# não permitir first_name = '' e last_name = ''
	validates :first_name, presence: true, allow_blank: false
	validates :last_name, presence: true, allow_blank: false
	after_create :add_moustache

	  def self.attr_accessible
    	[
      		:first_name, :last_name, :admin
    	]
    end

  	private

  	def add_moustache
      UpdateUserJob.set(wait: 30.seconds).perform_later(self)
    end
end
