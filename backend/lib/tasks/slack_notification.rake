namespace :slack_notification do
  desc "slack通知"
  task :slack => :environment do
    all_data = Habituation.all
    all_data.each do |habituation|
      puts "#{habituation.slack_notification}"
      notifier = Slack::Notifier.new(
        habituation.slack_notification,
        username: '習慣化したいこと'
      )
      notifier.ping habituation.title
    end
  end
end
