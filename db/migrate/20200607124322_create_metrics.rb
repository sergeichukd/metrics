class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.integer :cold
      t.integer :hot

      t.timestamps
    end
  end
end
