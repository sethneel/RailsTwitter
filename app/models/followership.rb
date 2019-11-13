class Followership < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followed_user, class_name: 'User'
end
