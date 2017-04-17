class Issue < ActiveRecord::Base
  serialize :labels, Array if Rails.env.development?
  serialize :assignees, Array if Rails.env.development?
  require 'push_chatwork_notification'

  after_save :push_notification

  def push_notification
    if level_changed? && labels.join.include?("level-")
      message = "[To:948996] Mai Trung Nghiaさん\n"
      message += "追加または更新されたレベルイシューがあります。\n"
      message += "[info][title]#{self.title}[/title]レベル： #{self.level}\nリンク： #{self.url}[/info]"
      PushChatworkNotification.push_noti message
    end
  end

  def self.report
    message = "[To:597252] 斎藤 幸士さん\n[To:948996] Mai Trung Nghiaさん\n"
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

  def self.weekly_report
    message = "[To:597252] 斎藤 幸士さん\n[To:948996] Mai Trung Nghiaさん\n"
    message += "お疲れ様です。\nレベルイシューの状況を共有させていただきます。\n"

    all_issues = Issue.where(level: [2,3], level_start_time: (10.business_days.ago..Time.now))
    all_count = all_issues.count
    fixed_count = 0
    tmp_mess = ""
    all_issues.each do |iss|
      if iss.status == "closed" || iss.labels.join.include?("pending")
        tmp_mess += "#{iss.url} (#{iss.status == "closed" ? "closed" : "pending"})\n"
        fixed_count += 1
      else
        tmp_mess += "#{iss.url} (open)\n"
      end
    end


    non_fixed_mess = ""
    one_month_issues = Issue.where(level: [2,3], level_start_time: (1.months.ago..Time.now))
    one_month_count = one_month_issues.count
    one_month_non_fixed_count = 0
    one_month_issues.each do |iss|
      if (iss.status == "closed" && iss.level_start_time <= 10.business_days.before(iss.closed_at)) || (iss.status == "open" && iss.level_start_time <= 10.business_days.ago)
        one_month_non_fixed_count += 1
        non_fixed_mess += "#{iss.url} (#{iss.status})\n"
      end
    end

    message += "[hr]最近一ヶ月間： #{1.months.ago.strftime('%Y年%m月%d日')} ~ #{Time.now.strftime('%Y年%m月%d日')}\n"
    message += "レベル２とレベル３のイッシュー件数： #{one_month_count}\n"
    message += "10営業日で対応できない件数： #{one_month_non_fixed_count}\n"
    message += non_fixed_mess

    message += "[hr]最近10営業日間： #{10.business_days.ago.strftime('%Y年%m月%d日')} ~ #{Time.now.strftime('%Y年%m月%d日')}\n"
    message += "レベル２とレベル３のイッシュー件数： #{all_count}\n"
    message += "対応済み件数： #{fixed_count}\n[hr]"
    message += tmp_mess

    PushChatworkNotification.push_noti message
  end
end
