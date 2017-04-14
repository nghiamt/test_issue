class Issue < ActiveRecord::Base
  serialize :labels, Array
  serialize :assignees, Array
  require 'push_chatwork_notification'

  after_save :push_notification

  def push_notification
    if level_changed?
      message = "[To:948996] Mai Trung Nghiaさん\n"
      message += "追加または更新されたレベルイシューがあります。\n"
      message += "[info][title]#{self.title}[/title]レベル： #{self.level}\nリンク： #{self.url}[/info]"
      PushChatworkNotification.push_noti message
    end
  end

  def self.report
    message = "[To:948996] Mai Trung Nghiaさん\n"
    message += "お疲れ様です。\nレベルイシューの状況を共有させていただきます。\n"
    
    [1,2,3].each do |i|
      count = 0
      tmp_mess = "" 
      Issue.where(level: i, status: "open").each do |iss|
        if iss.labels.join.exclude?("pending")
          count += 1
          tmp_mess += "#{iss.title} \n#{iss.url}\n"
        end
      end
      message += "[hr]Level-#{i}イシュー： #{count}件\n#{tmp_mess}"
    end

    message += "[hr]"

    PushChatworkNotification.push_noti message
  end

  def self.update_level_issues
    github = Octokit::Client.new(:access_token => ENV["GITHUB_ACCESS_TOKEN"])

    Issue.where(level: [1,2], status: "open").each do |iss|
      if iss.labels.join.exclude?("pending") && Time.now >= 5.business_days.after(iss.level_start_time)
        labels = iss.labels.delete_if{|lb| lb.index("level-").present?} << "level-#{iss.level + 1}"
        github.update_issue("nghiamt/test_issue", iss.number, :labels => labels)
      end
    end
  end
end
