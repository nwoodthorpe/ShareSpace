class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :messages

  validates :name, presence: true, allow_blank: false

  before_save :default_last_active

  private

  def default_last_active
    self[:last_active] ||= Time.new
  end
end
