class Status < ApplicationRecord
    belongs_to :user
    validates :content, length: { minimum:10 }
end
