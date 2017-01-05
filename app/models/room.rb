class Room < ApplicationRecord
  has_many :users

  validates_inclusion_of :locked, in: [:true, :false]
  validates_inclusion_of :public_room, in: [:true, :false]

  def private_room?
    !self[:public_room]
  end
end
