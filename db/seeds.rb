# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)]

data = {
  title: "【公開ページ】同一タブで外部サイトに遷移したのち、ブラウザバックすると元のページが崩れて見える", 
  number: 10789, 
  status: "open", 
  level_start_time: "2017-03-23".to_date, 
  created: "2017-03-23".to_date, 
  labels: ["cs-order", "level-2"], 
  url: "https://github.com/orcainc/homeup/issues/10789", 
  level: 2
}
Issue.create data

data = {
  title: "ページ編集画面のロゴの位置がずれている", 
  number: 11289, 
  status: "open", 
  level_start_time: "2017-04-14".to_date, 
  created: "2017-04-14".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/11289", 
  level: 1
}
Issue.create data

data = {
  title: "【要望】自動生成される「タグ・カテゴリページ」の改善", 
  number: 11139, 
  status: "open", 
  level_start_time: "2017-04-07".to_date, 
  created: "2017-04-07".to_date, 
  labels: ["cs-order", "level-1", "Improvement", "pending"], 
  url: "https://github.com/orcainc/homeup/issues/11139", 
  level: 1
}
Issue.create data

data = {
  title: "【要望】ブログ記事の直下にCTAを挿入できない問題の対策 ", 
  number: 11129, 
  status: "open", 
  level_start_time: "2017-04-06".to_date, 
  created: "2017-04-06".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/11129", 
  level: 1
}
Issue.create data

data = {
  title: "【要望】ALTの一括登録について ", 
  number: 11128, 
  status: "open", 
  level_start_time: "2017-04-06".to_date, 
  created: "2017-04-06".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/11128", 
  level: 1
}
Issue.create data

data = {
  title: "【要望】見出しパーツのフォントカラー・アライン変更時の操作性改善 ", 
  number: 11127, 
  status: "open", 
  level_start_time: "2017-04-06".to_date, 
  created: "2017-04-06".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/11127", 
  level: 1
}
Issue.create data

data = {
  title: "ページ編集画面で背景設定した画像がリピートされない ", 
  number: 11106, 
  status: "open", 
  level_start_time: "2017-04-05".to_date, 
  created: "2017-04-05".to_date, 
  labels: ["cs-order", "level-1", "coding"], 
  url: "https://github.com/orcainc/homeup/issues/11106", 
  level: 1
}
Issue.create data

data = {
  title: "ブログテンプレートのプレビューで500エラーが発生", 
  number: 10879, 
  status: "open", 
  level_start_time: "2017-03-25".to_date, 
  created: "2017-03-25".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/10879", 
  level: 1
}
Issue.create data

data = {
  title: "サイト編集以下の「メディア」という名称を「イメージフォルダ」等に変更した方が良い", 
  number: 10398, 
  status: "open", 
  level_start_time: "2017-03-01".to_date, 
  created: "2017-03-01".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/10398", 
  level: 1
}
Issue.create data

data = {
  title: "【要望】トレーニングシート、ブログ記事に自動保存機能を持たせてほしい", 
  number: 10122, 
  status: "open", 
  level_start_time: 6.days.ago.to_date, 
  created: "2017-02-08".to_date, 
  labels: ["cs-order", "level-1"], 
  url: "https://github.com/orcainc/homeup/issues/10122", 
  level: 1
}
Issue.create data



