class AddClosedAtToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :closed_at, :date
  end
end
