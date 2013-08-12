class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
    	t.decimal :steam_id, null: false, precision: 20, scale: 0
      t.boolean :is_admin, null: false, default: false

      t.timestamps
    end

    add_index :users, :steam_id, unique: true
  end
end
