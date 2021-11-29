# == Schema Information
#
# Table name: door_messages
#
#  id         :bigint           not null, primary key
#  message    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#
class DoorMessage < ApplicationRecord
  belongs_to :room
end
