class AddApprovedToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :approved, :boolean
  end
end
