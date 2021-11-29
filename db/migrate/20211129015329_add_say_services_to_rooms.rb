class AddSayServicesToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :say_services, :string, limit: 4000
  end
end
