CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'thinkr@oneall-site-432285-2.iam.gserviceaccount.com',
    google_storage_secret_access_key: 'b386c0a18ab65e250eed3a9889ec9cecb141a183'
  }
  config.fog_directory = 'thought-pictures'
end
