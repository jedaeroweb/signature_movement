class UserUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick
  before :cache, :normalize_filename
  after :store, :sync_db_filename

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
    process :resize_to_fill => [400,300]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
  %w(jpg jpeg gif png)
  end


  def normalize_filename(file)
    return unless file && file.original_filename

    ext = File.extname(file.original_filename)
    base = File.basename(file.original_filename, ext)

    normalized =
      base
        .unicode_normalize(:nfkd)
        .encode("ASCII", replace: "", undef: :replace)
        .gsub(/[^a-zA-Z0-9_-]/, "_")
        .downcase

    normalized = "file" if normalized.blank?

    if Rails.env.production?
      new_name = "#{normalized}_#{secure_token}#{ext}"
    else
      new_name = "#{normalized}#{ext}"
    end

    file.instance_variable_set(:@original_filename, new_name)
    file.instance_variable_set(:@filename, new_name)
  end

  protected

  def secure_token
    model.instance_variable_get(:"@#{mounted_as}_secure_token") ||
      model.instance_variable_set(
        :"@#{mounted_as}_secure_token",
        SecureRandom.hex(8)
      )
  end

  private

  def sync_db_filename(_file = nil)
    return unless model && model.photo&.file

    # 여기서 file.filename 대신 model.photo.file.filename 사용
    model.update_column(mounted_as, model.photo.file.filename)
  end
end
