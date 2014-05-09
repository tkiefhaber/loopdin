class AddPriorityAndCompleteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :important, :boolean, default: false
    add_column :comments, :addressed, :boolean, default: false
  end
end
