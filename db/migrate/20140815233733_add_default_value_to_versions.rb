class AddDefaultValueToVersions < ActiveRecord::Migration
  def change
    change_column :versions, :approved, :boolean, default: false
  end
end
