class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :title
      t.string :description
      t.integer :project_id

      t.timestamps
    end
  end
end
