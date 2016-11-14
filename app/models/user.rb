
class User < ActiveRecord::Base
  # has secure password validates password confirmation, presence
  #  and max length of 72 char
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 2}


private

  def self.authenticate_with_credentials(email, password)
    # try to find user
     if user = User.find_by_email(email)
        if user.authenticate(password)
          user
        end
     end
  end

end


# need email validator



