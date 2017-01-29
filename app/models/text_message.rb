class TextMessage < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2000 }

  class << self
    def data_to_obj(data)
      TextMessage.create(content: data)
    end
  end

  def render
    self[:content] || ""
  end
end
