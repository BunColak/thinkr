CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOGZU5PUNJCW4VD2STC',
    google_storage_secret_access_key: 'zYbTNqXWWKNi+I3x3Iar/9BJJHW7SDw7+plhpmOc'
  }
  config.fog_directory = 'thought-pictures'
end
