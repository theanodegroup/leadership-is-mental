class DocumentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  make_private # Helper for ensuring it's private

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.bin}/#{model.id}"
  end
end
