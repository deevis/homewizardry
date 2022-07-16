class AddLastSeenDateToSensors < ActiveRecord::Migration[7.0]
  def change
    add_column :sensors, :last_seen_date, :datetime
  end
end
