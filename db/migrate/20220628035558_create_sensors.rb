class CreateSensors < ActiveRecord::Migration[7.0]
  def change
    create_table :sensors do |t|
      t.string :name
      t.string :sensor_type, limit: 30
      t.string :entity_id
      t.string :battery_entity_id
      t.integer :battery_level
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
