class CreateJoinTableUserProject < ActiveRecord::Migration
  def change
    create_table :collaborations, column_options: {null: false} do |t|
      t.integer :project_id
      t.integer :user_id
      t.index [:user_id, :project_id]
      t.index [:project_id, :user_id]
    end
  end
end
