class AddGuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :player_id, :integer
    add_index :users, :player_id, unique: true
  end
end
