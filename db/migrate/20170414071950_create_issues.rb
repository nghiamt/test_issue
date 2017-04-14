class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :number
      t.text :content
      t.string :status
      t.date :level_start_time
      t.date :created
      t.string :labels, array: true, default: []
      t.string :assignees, array: true, default: []

      t.timestamps
    end
  end
end
