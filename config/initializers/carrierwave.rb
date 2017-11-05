CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
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

if Rails.env.test?
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end 

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end 
    end 
  end 
end