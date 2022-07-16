class AddDoorContactBatteryLevelToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :door_contact_battery_level, :integer
  end
end
