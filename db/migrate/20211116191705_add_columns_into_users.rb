class AddColumnsIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_verified, :boolean, default: false
    add_column :users, :verification_code, :string
  end
end
