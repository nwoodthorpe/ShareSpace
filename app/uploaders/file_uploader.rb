class FileUploader < CarrierWave::Uploader::Base
  storage :fog
end
