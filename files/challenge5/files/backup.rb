# encoding: utf-8

##
# Backup v4.x Configuration
#
# Documentation: http://backup.github.io/backup
# Issue Tracker: https://github.com/backup/backup/issues

Model.new(:laravel, 'Backup the database and files for the laravel application') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  database MySQL do |db|
    db.name               = "homestead"
    db.username           = "root"
    db.socket              = "/var/run/mysqld/mysqld.sock"
  end

  archive :shared do |archive|
    archive.add "/var/www/html/quickstart"
    archive.tar_options '--warning=no-file-changed'
  end

  compress_with Gzip

  #$ openssl aes-256-cbc -d -base64 -in my_backup.tar.enc -out my_backup.tar
  encrypt_with OpenSSL do |encryption|
    encryption.password = "alskdjf92kwj{$}"
    encryption.base64   = true
    encryption.salt     = true
  end

  Storage::S3.defaults do |s3|
    s3.region             = "us-west-2"
    s3.bucket             = "learn-devpass-backups"
    s3.path               = ''
    s3.encryption         = :aes256
    s3.storage_class      = :standard_ia
    s3.access_key_id      = 'AXXXXXXXXXXXXX'
    s3.secret_access_key  = '9XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  end

  # Grandfather - Father - Sons implementation
  time = Time.now

  if time.day == 1  # first day of the month
    storage_id = :monthly
    keep = 12000  # only good until the year 3014
    store_with S3, storage_id do |s3|
      s3.keep               = keep
    end
  end

  if time.sunday?
    storage_id = :weekly
    keep = 8
    store_with S3, storage_id do |s3|
      s3.keep               = keep
    end
  end

  storage_id = :daily
  keep = 14

  store_with S3, storage_id do |s3|
    s3.keep               = keep
  end

  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true

    # The integration token
    slack.webhook_url = 'https://hooks.slack.com/services/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'
  end
end
