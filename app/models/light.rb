# == Schema Information
#
# Table name: lights
#
#  id         :bigint           not null, primary key
#  entity_id  :string(255)
#  name       :string(255)
#  room_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Light < ApplicationRecord

    belongs_to :room

    validates_presence_of :entity_id
    validates_uniqueness_of :entity_id
    validates_presence_of :name
    validates_uniqueness_of :name

    def status(ha_light_config = nil)
      if ha_light_config.nil?
        Rails.logger.info "Getting :rgb_light config from NodeRedService"
        ha_light_config = NodeRedService.get(:rgb_lights)
      end
      # find the light in the config
      my_config = ha_light_config.detect{ |l| l['entity_id'] == self.entity_id }
      if my_config.nil?
        return "Unknown"
      else
        rgb_color = my_config.dig('attributes','rgb_color')
        hex_color = nil
        if rgb_color.present?
          # convert to hex color
          hex_color = rgb_color.map{|c| c.to_s(16).rjust(2, '0')}.join
          Rails.logger.info "Light[#{self.id}] HEX COLOR: #{hex_color}"
        end
        config = {state: my_config['state'], rgb_color: rgb_color, hex_color: hex_color}
        Rails.logger.info "Returning status for Light[#{self.id}:#{self.entity_id}]  #{config}"
        return config
      end

    end
    def set_color(r, g, b)
      NodeRedService.post(:rgb_light, entity_id: self.entity_id, r: r, g: g, b: b)
    end

    def self.set_all_color(r,g,b)
      threads = []
      Light.order(:entity_id).all.each do |l|
        threads << Thread.new { l.set_color(r,g,b)}
      end
      threads.map{|t| t.value}
    end

    def self.color_cycle_all(count=1000, colors =  [[255,0,0], [0,255,0], [0,0,255], [255,0,255]])
      Thread.new {count.times{ colors.each{|r,g,b| Light.set_all_color(r,g,b); sleep 4}}}
      "Cycling started on background thread"
    end
end
