# == Schema Information
#
# Table name: rooms
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  door_contact_id            :string(255)
#  speaker_id                 :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  cooldown_seconds           :integer          default(5)
#  cooldown_started           :datetime
#  quiet_hours                :string(255)
#  say_services               :string(4000)
#  door_contact_battery_level :integer
#
class Room < ApplicationRecord
  has_many :door_messages
  has_many :lights
  has_many :played_messages
  has_many :sensors
  
  serialize :say_services, Array

  default_scope ->{order("name ASC")}

  validates_format_of :quiet_hours, with: /\d\d?[ap]m-\d\d?[ap]m/, allows_nil: true, allows_blank: true, if: ->(t){t.quiet_hours.present?}


  def say(message=nil, message_type: nil)
    message = get_message(message_type) if message.blank?
    NodeRedService.get(:say, {speaker: speaker_id.split(".").last, msg: message})
    message
  end

  def get_message(message_type=nil)
    # was originally: room.door_messages.sample.message
    options = say_services.clone
    message_type ||= options.sample
    message = case(message_type)
    when 'messages'
      door_messages.sample.message
    else
       JokeGenerator.tell_joke(message_type)
    end
    Rails.logger.info "Got message[#{message_type}] for Room[#{self.name}]: #{message}"
    message = message.gsub("\n", "  ").gsub("'", "").gsub("&#39;", "").gsub("&", "and").gsub("\"", "").gsub("\r", "").gsub("\t", "")
    Rails.logger.info "Translated message to say: #{message}"
    played_message = played_messages.where(message: message, message_type: message_type).first_or_create
    played_message.updated_at = Time.now
    played_message.save!
    message
  end


  def cooling_down?
    currently_cooling_down = if cooldown_started
      Time.now < (self.cooldown_started + self.cooldown_seconds) 
    else
      false
    end
    if !currently_cooling_down
      # Start our next cooldown period
      self.cooldown_started = Time.now
      save!
    end
    currently_cooling_down
  end

  def quiet_hours?
    return false if self.quiet_hours.blank?
    # "9am-3pm", or "10pm-8am"
    start_time, end_time = self.quiet_hours.split("-")
    if start_time.index("pm") && end_time.index("am")
      # this is overnight, perform 2 checks...
      Time.zone.now.between?(Time.zone.parse(start_time), Time.zone.parse("11:59:59.999pm")) ||
      Time.zone.now.between?(Time.zone.parse("12am"), Time.zone.parse(end_time))
    else
      Time.zone.now.between?(Time.zone.parse(start_time), Time.zone.parse(end_time))
    end
  end

end
