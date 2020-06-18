class RemoveEmailFromTableUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :email
  end

  def down
    add_column :users, :email, :string
  end
end
