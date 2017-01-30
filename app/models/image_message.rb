class ImageMessage < ApplicationRecord
  mount_uploader :image, ImageUploader

  class << self
    def factory(data)
      ImageMessage.create(image: data[:attachment])
    end
  end

  def render
    "<a class='uploaded-image-container' href='#{image.url}' target='_blank'>
      <img class='uploaded-image' src='#{image.url}'></img>
    </a>".html_safe
  end
end
