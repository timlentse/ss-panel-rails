# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, "~/current/log/cron_log.log"

job_type :rake,    "cd :path && :environment_variable=:environment /usr/local/bin/bundle exec rake :task --silent :output"

every 1.day, at: "0:00 am" do
  rake 'traffic'
end
