class AddFileToVersions < ActiveRecord::Migration
  def self.up
    add_attachment :versions, :file
  end

  def self.down
    remove_attachment :versions, :file
  end
end
