class AddLevelToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :level, :integer
  end
end
