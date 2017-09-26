CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'thinkr@thinkr-181119.iam.gserviceaccount.com',
    google_storage_secret_access_key: 'e3883d7c563422958ef6d2ac2e09c049bf8b4dda'
  }
  config.fog_directory = 'thought-pictures'
end
