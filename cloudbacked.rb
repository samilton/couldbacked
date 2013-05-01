#!/usr/bin/ruby

require 'rubygems'
require 'logger'
@logger = Logger.new("hazel.log")

begin
  require 'fog'
rescue LoadError
  @logger.error "Unable to load Fog"
end

if File.exists? "#{ENV['HOME']}/.cloudbacked"
  config = YAML::load(File.open("#{ENV['HOME']}/.cloudbacked"))
  @rackspace = config['rackspace']
  @s3 = config['s3']
else
  @logger.warn "unable to find configuration file. please create to try again"
end

def upload(file, directory, options={})
  connection = Fog::Storage.new(options)
  directory = connection.directories.get directory
  directory.files.create :key => File.basename(file), :body => File.open(file)
end

file = ARGV[0]

if @rackspace['enabled']
  @logger.info "Attempting to upload #{file} to Rackspace Container #{@rackspace[:container]}"
  options = {
    :provider           => 'Rackspace',
    :rackspace_username => @rackspace['username'],
    :rackspace_api_key  => @rackspace['api_key'],
    :connection_options => {}
  }

  upload(file, @rackspace['container'], options)

end

if @s3['enabled']
  @logger.info "Attempting to upload #{file} to S3 Bucket #{@s3[:bucket]}"
  options = {
    :provider              => 'AWS',
    :aws_access_key_id     => @s3['access_key'],
    :aws_secret_access_key => @s3['secret_access_key'],
    :connection_options    => {}
  }

  upload(file, @s3['bucket'], options)
end

