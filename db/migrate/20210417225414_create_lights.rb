class CreateLights < ActiveRecord::Migration[6.1]
  def change
    create_table :lights do |t|
      t.string :entity_id
      t.string :name
      t.belongs_to :room, foreign_key: true
      t.timestamps
    end
  end
end
