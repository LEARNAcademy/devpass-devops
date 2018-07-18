---
title: Challenge Four
permalink: /docs/challenge4/
---

## Create a Backup for Your Rails and Laravel Apps

Install the [backup Ruby gem](http://backup.github.io/backup/v4/) and configure it to backup both the code files and the databases for both apps.

You will need to install ruby 2.3 using RVM. `rvm install 2.3 && rvm use 2.3`

> Don't let the maintenance notice fool you, backup is back under active development. They just haven't taken down the notice yet.

Send the backups to S3.

You also need to create a cron job that runs the backup daily.

> Hint: You need to set the right RVM environment to use in cron.  Try `/home/ubuntu/.rvm/wrappers/ruby-2.3.7/backup`

Questions

1) We backed up code files and databases for this challenge. We would normally only backup one or the other.  Which one? and what else might we back up in our app?

2) We are backing up to S3 tonight... why might we want to backup our EC2 hosted apps to somewhere besides Amazon S3?


## Logging

Set up a [Papertrail account](https://papertrailapp.com), get syslog logs on the server, and the logs of all 3 of your apps to Papertrail

Questions

1) Can you see the logs for cron? Is your backup running?

2) When you hit one of the apps via http, do you see both Nginx and App logs for the request? Can you create a saved search that shows only the Nginx and App logs for the Node app?
