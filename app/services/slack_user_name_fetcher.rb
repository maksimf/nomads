require 'net/http'

class SlackUserNameFetcher
  API_URL = 'https://slack.com/api/users.info'

  def self.call
    NomadCity.all.each do |record|
      binding.pry
      fetch_nickname_from_slack(record) unless record.nickname
    end
  end

  private

  def self.fetch_nickname_from_slack(record)
    res = Net::HTTP.get_response(
      URI("#{API_URL}?token=#{ENV['NOMAD_SLACK_API_TOKEN']}&user=#{record.user}")
    )
    nickname = JSON.parse(res.body, symbolize_names: true).dig(:user, :profile, :display_name)

    record.update(nickname: nickname)
  end
end