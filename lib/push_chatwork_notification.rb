class PushChatworkNotification
  ENDPOINT = "https://api.chatwork.com/v2/rooms/#{ENV['CHATWORK_ROOM_ID']}/messages"
  GITHUB = Octokit::Client.new(:access_token => ENV["GITHUB_ACCESS_TOKEN"])

  def self.push_noti message
    Curl.post ENDPOINT, body: message do |curl|
      curl.headers["X-ChatWorkToken"] = ENV["CHATWORK_TOKEN"]
    end
  end
end