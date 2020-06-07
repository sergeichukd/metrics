class AddUserIdToMetrics < ActiveRecord::Migration[6.0]
  def change
    change_table :metrics do |t|
      t.belongs_to :user
    end
  end
end
