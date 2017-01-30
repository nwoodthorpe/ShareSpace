class TextMessage < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2000 }

  class << self
    def factory(data)
      TextMessage.create(content: data)
    end
  end

  def render
    self[:content] || ""
  end
end
