CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      host:                  ENV['AWS_S3_ASSET_URL'],
      region:                ENV['AWS_S3_REGION']
    }
    config.fog_directory  = ENV['AWS_S3_BUCKET_NAME']
    config.fog_public     = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" }
    config.storage = :fog
  else
    config.storage = :file
    config.enable_processing = false
  end

end