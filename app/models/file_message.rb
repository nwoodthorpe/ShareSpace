class FileMessage < ApplicationRecord
  mount_uploader :file, FileUploader

  validates :file, file_size: { less_than: 500.megabytes }

  class << self
    def factory(data)
      FileMessage.create(file: data[:attachment])
    end
  end

  def render
    "<a class='link' href='#{file.url}' target='_blank'>
      #{file.path.split('/')[1]}
    </a>".html_safe
  end
end
