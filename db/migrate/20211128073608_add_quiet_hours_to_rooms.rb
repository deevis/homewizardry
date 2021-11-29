class AddQuietHoursToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :quiet_hours, :string
  end
end
