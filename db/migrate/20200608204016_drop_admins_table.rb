class DropAdminsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :admins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  # def change
  # end
end
