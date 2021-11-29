class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :door_contact_id
      t.string :speaker_id

      t.timestamps
    end
  end
end
