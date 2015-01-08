class User < ActiveRecord::Base
	has_secure_password
	validates :username, presence: true, uniqueness: true
	after_destroy :ensure_one_admin_exists

	def ensure_one_admin_exists
		if User.count.zero?
			raise "The last user cannot be deleted."
		end
	end
end
