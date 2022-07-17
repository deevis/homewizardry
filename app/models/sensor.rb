# == Schema Information
#
# Table name: sensors
#
#  id                :bigint           not null, primary key
#  name              :string(255)
#  sensor_type       :string(30)
#  entity_id         :string(255)
#  battery_entity_id :string(255)
#  battery_level     :integer
#  room_id           :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  last_seen_date    :datetime
#
class Sensor < ApplicationRecord
  belongs_to :room

  SENSOR_TYPES = %w(DOOR_CONTACT MOTION_SENSOR)

  validates :entity_id, presence: true
  validates :sensor_type, inclusion: { in: SENSOR_TYPES }
  before_validation :set_defaults

  def self.update_entities
    entities = NodeRedService.get(:entities)
    Sensor.find_each do |s|
      entity = entities.detect{|e| e['entity_id'] == s.entity_id}
      if entity.present?
        last_updated_time = Time.zone.parse(entity['last_updated'])
        s.last_seen_date = last_updated_time if s.last_seen_date.nil? || last_updated_time > s.last_seen_date
      end
      battery = entities.detect{|e| e['entity_id'] == s.battery_entity_id}
      if battery.present?
        s.battery_level = battery['state'].to_i
        last_updated_time = Time.zone.parse(battery['last_updated'])
        s.last_seen_date = last_updated_time if s.last_seen_date.nil? || last_updated_time > s.last_seen_date
      end
      s.save!
    end
    return entities
  end

  def self.update_battery_levels
    # [ {"entity_id":"sensor.upstairs_door_battery","name":"Upstairs Door Battery","state":"26"},
    #   {"entity_id":"sensor.garage_door_battery","name":"Garage Door Battery","state":"37"}
    #
    levels = NodeRedService.get(:batteries)

    # each door contact has a battery level as such:
    # sensor.upstairs_door_battery ==> binary_sensor.upstairs_door_contact
    # ie: we prepend "binary_" and replace "battery" with "contact"
    levels.each do |x|
      s = Sensor.find_by(battery_entity_id: x['entity_id']) rescue nil
      if s.present?
        # update battery level
        s.battery_level = x['state'].to_i
        s.save!
      else
        Rails.logger.warn("No sensor found for: '#{x['entity_id']}'")
        next
      end
    end
  end
  
  private
  def set_defaults
    self.name ||= self.entity_id.split(".").last.titleize if self.entity_id.present?
  end

end
