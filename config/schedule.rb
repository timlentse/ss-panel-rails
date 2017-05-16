# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, "/tmp/cron_log.log"

job_type :rake,    "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"

every 1.day, at: "1:00 am" do
  rake 'traffic'
end

every 1.month, at: "0:00 am" do
  rake 'reset_traffic'
end
