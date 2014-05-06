class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :version_id
      t.string :text
      t.integer :start_time

      t.timestamps
    end
  end
end
