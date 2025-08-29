CarrierWave.configure do |config|
  if Rails.env.production?
    require 'dotenv/load'
    require 'fog/azurerm'
    config.storage = :fog
    config.fog_credentials = {
      :provider => ENV['FOG_PROVIDER'], # required
      :azure_storage_account_name => ENV['AZURE_STORAGE_ACCOUNT_NAME'], # required
      :azure_storage_access_key => ENV['AZURE_STORAGE_ACCESS_KEY'] # required
      # :region => 'ap-northeast-1' # optional, defaults to 'us-east-1'
      #:host                   => 's3.example.com',             # optional, defaults to nil
      #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory = ENV['FOG_DIRECTORY']
    #config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' } # optional, defaults to {}
  else
    config.storage = :file
  end

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
