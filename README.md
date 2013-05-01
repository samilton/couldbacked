This is a simple script that can be used to with Hazel to upload files to Amazon S3 or Rackspace (or both for the paranoid). It sprang out of a desire to make sure that I was able to protect my photograper wife from what seems like an unnatural ability to burn through harddrives at an alarming rate. It also protects against fire and freak accidents.

To use this script, clone the repository and thne follow these simple steps.

```bash

%> # This will install fog, confirm you have hazel and create a sample configuration file
%> script/setup

```

You can do all of the steps the script performs by installing fog and creating the configuration file

```bash
%> sudo /usr/bin/gem install fog
%> touch ~/.cloudback
```

Next, simple use your favorite editor to edit the configuration file to specify API Keys, S3 bucket and/or Rackspace container. When the script starts it reads this configuration and will perform the copies to the services based on whats enabled. To enable S3 make sure the key enable_s3 is set to true and to enable Rackspace make sure enable_rackspace is set to true.

```yaml
s3:
  enabled: true
  api_key: xxxyyyy
  secret_key: abc123
  bucket: backup_the_backup

rackspace:
  enabled: true
  api_key: 123456
  container: fuzzball
```

