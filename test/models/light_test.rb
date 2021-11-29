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
require "test_helper"

class LightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
