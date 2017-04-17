def get_issue
  github = Octokit::Client.new(:access_token => ENV["GITHUB_ACCESS_TOKEN"])
  today = Date.today
  get_number = -> (page, ret) do
    puts "page:#{page}"
    issues = github.search_issues("repo:orcainc/homeup is:issue created:#{today.months_ago(2)..today}", per_page: 100, page: page+1)
    issues[:items].each do |item|
      ret << item[:number]
      labels = item[:labels].map{|lb| lb[:name]}
      data = {
        title: item[:title],
        url: item[:html_url],
        number: item[:number].to_i,
        status: item[:state],
        labels: labels,
        content: item[:body],
        created: item[:created_at].to_date
      }

      data[:closed_at] = item[:closed_at].to_date if item[:closed_at].present?
      Issue.create data
    end
    get_number.(page+1, ret) if issues[:total_count] > ret.count
  end

  issue_numbers = []
  get_number.(0, issue_numbers)

  issue_numbers.each do |num|
    github.issue_events("orcainc/homeup", num).each do |event|
      if event[:event] == "labeled" && event[:label][:name].include?("level-")
        data = {
          level_start_time: event[:created_at].to_date,
          level: event[:label][:name].gsub("level-", "").to_i
        }
        Issue.find_by(number: num).update data
      end
    end
  end
end