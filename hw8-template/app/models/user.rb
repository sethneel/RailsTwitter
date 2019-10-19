class User < ApplicationRecord
  has_many :friends, -> { where friendships: { state: 'accepted' } }, through: :friendships
  has_many :requested_friends, -> { where friendships: { state: 'requested' } }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where friendships: { state: 'pending' } }, through: :friendships, source: :friend
end
