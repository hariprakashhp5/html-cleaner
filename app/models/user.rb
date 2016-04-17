class User < ActiveRecord::Base
	has_secure_password

	def editor? 
		self.role == '2' 
	end

	def admin?
		self.role == '1'
	end
end
