class TextMessage < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2000 }

  class << self
    def factory(data)
      TextMessage.create(content: data)
    end
  end

  def render
    return (self[:content] || '') unless code?

    "<pre class='brush: plain'>".html_safe + self[:content][3..-1] + "</pre>".html_safe
  end

  def code?
    self[:content][0..2] == '```'
  end
end
