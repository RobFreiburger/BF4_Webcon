class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.text :name
      t.text :description
      t.string :battlelog_name
      t.string :guid
      t.string :ip_address
      t.integer :rcon_port, limit: 5
      t.string :rcon_password
      t.boolean :allow_use, default: false

      t.timestamps
    end
    add_index :servers, :name, unique: true
  end
end
