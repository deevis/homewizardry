require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '4h' do
  Sensor.update_battery_levels
end

