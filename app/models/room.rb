require 'random_alphanumeric'

class Room < ApplicationRecord
  has_many :users
  before_save :assign_short_url, :set_default_values

  def private_room?
    !self[:public_room]
  end

  private

  def set_default_values
    self[:locked] = false if self[:locked].nil?
    self[:public_room] = true if self[:public_room].nil?
  end

  def assign_short_url
    return if self[:short_url]

    loop do
      self[:short_url] = RandomAlphaNumeric.random_word(4)
      break unless Room.find_by(short_url: self[:short_url])
    end
  end
end
