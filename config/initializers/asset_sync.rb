if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = ENV['FOG_PROVIDER']
    config.azure_storage_account_name = ENV['AZURE_STORAGE_ACCOUNT_NAME']
    config.azure_storage_access_key = ENV['AZURE_STORAGE_ACCESS_KEY']
    config.fog_directory = ENV['FOG_DIRECTORY']

    # Don't delete files from the store
    config.existing_remote_files = "delete"

    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true

    # Use the Rails generated 'manifest.yml' file to produce the list of files to
    # upload instead of searching the assets directory.
    config.manifest = true

    config.custom_headers = { '.*' => { cache_control: 'max-age=31536000', expires: 1.year.from_now.httpdate } }

    config.add_local_file_paths do
      # Add files to be uploaded
      Dir.chdir(Rails.root.join('public')) do
        Dir[File.join('packs', '**', '**')]
      end
    end
  end
end