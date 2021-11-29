# == Schema Information
#
# Table name: rooms
#
#  id               :bigint           not null, primary key
#  name             :string(255)
#  door_contact_id  :string(255)
#  speaker_id       :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cooldown_seconds :integer          default(5)
#  cooldown_started :datetime
#  quiet_hours      :string(255)
#  say_services     :string(4000)
#
require "test_helper"

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
