# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)]

Issue.create title: "eeeee", number: 31, status: "open", level_start_time: 1.days.ago.to_date, created: 1.days.ago.to_date, labels: ["bug", "level-1"], url: "https://github.com/nghiamt/test_issue/issues/32", level: 1
