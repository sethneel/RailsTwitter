class User < ApplicationRecord
    has_many :statuses, dependent: :destroy
end
