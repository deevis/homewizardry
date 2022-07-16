# == Schema Information
#
# Table name: played_messages
#
#  id           :bigint           not null, primary key
#  message      :string(1000)
#  message_type :string(40)
#  room_id      :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class PlayedMessage < ApplicationRecord

  belongs_to :room

end
