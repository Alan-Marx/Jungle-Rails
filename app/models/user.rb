class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 5 }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_confirmation,
            :email,
            :first_name,
            :last_name, presence: true
end
