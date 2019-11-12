require 'bcrypt'
class User < ApplicationRecord
    include BCrypt
    has_many :statuses, dependent: :destroy
    validate :names_upcase
    validates :email,  uniqueness:true 
    
    def names_upcase
        if last_name != last_name.upcase 
            errors.add(:last_name, "Names must be upper case.")
        end 
            
        if first_name != first_name.upcase
            errors.add(:first_name, "Names must be upper case.")
        end
    end

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
end
