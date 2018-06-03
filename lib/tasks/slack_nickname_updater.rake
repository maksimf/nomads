desc "Updates slack nicknames in Mongo"
task :slack_nickname_updater => :environment do
  SlackUserNameFetcher.call
end