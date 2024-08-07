# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'
job_type :runner, %q( cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output )
set :output, 'log/cron.log'

# every :day do
#   runner "Request.send_reconfirm_email"
# end

every 3.minutes do
  runner 'Request.send_reconfirm_email'
end
