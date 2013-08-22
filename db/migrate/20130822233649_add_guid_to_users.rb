class AddGuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :player_id, :string, limit: 32
    add_index :users, :player_id, unique: true
  end
end
