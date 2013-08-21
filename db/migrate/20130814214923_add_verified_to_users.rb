class AddVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_verified, :boolean, default: false
    add_column :users, :verification_token, :string
  end
end
