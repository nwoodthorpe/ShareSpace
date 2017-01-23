require 'random_alphanumeric'

class Room < ApplicationRecord
  attr_accessor :password

  has_many :users
  has_many :messages
  before_save :assign_short_url, :set_default_values, :handle_password
  validates :password,
    presence: true,
    length: { in: 6..100 },
    if: :private_room?

  def private_room?
    !self[:public_room]
  end

  def is_password?(password)
    return true if self[:public_room]
    self[:encrypted_password] == BCrypt::Engine.hash_secret(password, self[:salt])
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

  def handle_password
    unless self[:public_room]
      self[:salt] = BCrypt::Engine.generate_salt
      self[:encrypted_password] = BCrypt::Engine.hash_secret(password, self[:salt])
    end

    @password = nil
  end
end
