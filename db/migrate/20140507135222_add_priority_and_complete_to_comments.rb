class AddPriorityAndCompleteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :priority, :integer
    add_column :comments, :addressed, :boolean, default: false
  end
end
