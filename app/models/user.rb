class User < ApplicationRecord
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
end
