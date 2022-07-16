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
#
require "test_helper"

class SensorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
