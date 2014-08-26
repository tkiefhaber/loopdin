class AddApprovedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :approved_at, :datetime
  end
end
