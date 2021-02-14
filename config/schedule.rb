# frozen_string_literal: true

set :output, File.join(File.expand_path(__dir__).sub('/config', ''), 'log', 'cron_tasks.log')

every 1.hour do
  runner 'Transactions::DestroyOld.call'
end
