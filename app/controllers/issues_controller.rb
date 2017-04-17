class IssuesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  end

  def report
    Issue.report
    respond_to do |format|
      format.html{redirect_to root_url}
    end
  end

  def update_issue
    Issue.update_level_issues
    respond_to do |format|
      format.html{redirect_to root_url}
    end
  end

  def hook
    issue_info = params["issue"]
    changed_label = params["label"]

    issue = Issue.where(number: issue_info["number"]).first
    labels = issue_info["labels"].to_a.map{|lb| lb["name"]}
    level = issue_info["labels"].to_a.map{|lb| lb["name"].gsub("level-", "").to_i}.max

    data = {
      title: issue_info["title"],
      url: issue_info["html_url"],
      number: issue_info["number"].to_i,
      status: issue_info["state"],
      labels: labels,
      level: level,
      content: issue_info["body"],
      created: issue_info["created_at"].to_date
    }
    
    if labels.join.include?("level-") && labels.exclude?("pending")
      if Hash(changed_label)["name"].to_s.include?("level-") || issue.blank?
        data[:level_start_time] = Time.now.to_date
      end
    end
    if issue.blank?      
      issue = Issue.create data
    else
      issue.update data
    end
  end
end
