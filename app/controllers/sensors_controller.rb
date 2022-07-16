class SensorsController < ApplicationController

  def index
    @entities = NodeRedService.get(:entities)

    @available_batteries = @entities.select{|x| x['entity_id'].index("battery")}
    @available_contacts = @entities.select{|x| x['entity_id'].index("contact")}

    @sensors = Sensor.joins(:room).order("rooms.name ASC, entity_id ASC")
  end

end
