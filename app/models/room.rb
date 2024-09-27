class Room < ApplicationRecord
  has_many :messages

  enum visibility: [:public_access, :private_access]
end
