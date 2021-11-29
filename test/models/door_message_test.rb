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
require "test_helper"

class DoorMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
