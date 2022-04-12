class User < ActiveRecord::Base
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip) 
    if user
      if user.authenticate(password)
        user
      else
        nil
      end
    end
  end

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password,  length: { minimum: 3 }, presence: true
  validates :password_confirmation, presence: true

end
