class AddRoomToDoorMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :door_messages, :room, foreign_key: true
  end
end
