class AddCooldownSecondsToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :cooldown_seconds, :integer, default: 5
    add_column :rooms, :cooldown_started, :datetime
  end
end
