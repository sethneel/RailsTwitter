require 'bcrypt'
class User < ApplicationRecord
    include BCrypt
    has_many :statuses, dependent: :destroy
    # set up followed/followers depedency
    has_many :passive_followships, class_name: 'Followership', foreign_key: 'followed_user_id', dependent: :destroy
    has_many :followers, through: :passive_followships, source: :follower_user
    has_many :active_followships, class_name: 'Followership', foreign_key: 'follower_user_id', dependent: :destroy
    has_many :followings, through: :active_followships, source: :followed_user
    
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
