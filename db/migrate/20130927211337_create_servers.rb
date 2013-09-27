class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :guid
      t.string :ip_address
      t.integer :rcon_port
      t.string :rcon_pw

      t.timestamps
    end

    add_index :servers, :name, unique: true
  end
end
