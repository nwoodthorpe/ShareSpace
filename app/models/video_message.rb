class VideoMessage < ApplicationRecord
  mount_uploader :video, VideoUploader

  validates :video, file_size: { less_than: 500.megabytes }

  class << self
    def factory(data)
      VideoMessage.create(video: data[:attachment])
    end
  end

  def render
    '<video width="200" height="140" controls>
      <source src="'.html_safe + video.url + '" type="video/mp4">'.html_safe +
    '</video>'
  end
end
