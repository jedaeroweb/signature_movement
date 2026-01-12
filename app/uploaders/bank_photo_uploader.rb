class BankPhotoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick
  before :cache, :filename

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def size_range
    1.byte..1.megabytes
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.production?
      return "#{model.class.to_s.underscore}/#{model.id}"
    else
      return "uploads/#{model.class.to_s.underscore}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def scale(width, height)
    # do something
  end

  # Create different versions of your uploaded files:
  version :small_thumb do
    process :resize_to_fill => [50, 50]
  end

  version :medium_thumb do
    process :resize_to_fill => [100, 100]
  end

  version :large_thumb do
    process :resize_to_fill => [400, 300]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
  %w(jpg jpeg gif png)
  end

  def filename
    return unless original_filename

    @safe_filename ||= begin
                         ext = File.extname(original_filename)
                         base = File.basename(original_filename, ext)

                         normalized =
                           base
                             .unicode_normalize(:nfkd)
                             .encode("ASCII", replace: "", undef: :replace)
                             .gsub(/[^a-zA-Z0-9_-]/, "_")
                             .downcase

                         "#{normalized}_#{secure_token}#{ext}"
                       end
  end

  protected

  def secure_token
    model.instance_variable_get(:"@#{mounted_as}_secure_token") ||
      model.instance_variable_set(
        :"@#{mounted_as}_secure_token",
        SecureRandom.hex(8)
      )
  end
end
