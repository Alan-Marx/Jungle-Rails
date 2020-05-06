class User < ActiveRecord::Base


  has_secure_password
  validates :password, length: { minimum: 5 }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_confirmation,
            :email,
            :first_name,
            :last_name, presence: true

 
 

  def self.authenticate_with_credentials(email, password)
    
    user = User.find_by_email(email.downcase.strip)
    user if user&.authenticate(password)

  end
end
