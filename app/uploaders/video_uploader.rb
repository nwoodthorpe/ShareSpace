class VideoUploader < CarrierWave::Uploader::Base
  storage :fog
end
