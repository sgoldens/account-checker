class RemoveNameFromUsers < ActiveRecord::Migration[5.1]
  def self.down
    remove_column :users, :name
  end
end
