class User < ApplicationRecord
  has_many :messages
  has_many :in_rooms, through: :messages, source: :room
end
