class AddGroupIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :group_id, :integer
    add_index :projects, :group_id
  end
end
