if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = ENV['FOG_PROVIDER']
    config.azure_storage_account_name = ENV['AZURE_STORAGE_ACCOUNT_NAME']
    config.azure_storage_access_key = ENV['AZURE_STORAGE_ACCESS_KEY']
    config.fog_directory = ENV['FOG_DIRECTORY']

    # ❗ Propshaft는 삭제 안 하는 게 안전
    config.existing_remote_files = "delete"

    # ❗ CDN/Azure가 gzip하면 끄는 게 좋음
    config.gzip_compression = false

    # ❗ Propshaft manifest
    config.manifest = true

    config.custom_headers = {
      '.*' => {
        cache_control: 'public, max-age=31536000, immutable'
      }
    }

    config.add_local_file_paths do
      Dir.chdir(Rails.root.join('public')) do
        Dir['assets/**/*'] + Dir['fonts/**/*']+ Dir['images/**/*']
      end
    end
  end
end
