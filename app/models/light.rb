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
end
