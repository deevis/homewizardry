class LightsController < ApplicationController
  before_action :set_light, only: %i[ set_color show edit update destroy ]


  def set_color
    rgb_hex = params['color']['rgb']
    r, g, b = rgb_hex.match(/^#(..)(..)(..)$/).captures.map(&:hex)
    NodeRedService.post(:rgb_light, entity_id: @light.entity_id, r: r, g: g, b: b)
    redirect_to @light, notice: "Color set"
  end


  # GET /lights or /lights.json
  def index
    @rgb_lights = NodeRedService.get(:rgb_lights)
    @lights = Light.joins(:room).order("rooms.name ASC, entity_id ASC")
  end

  # GET /lights/1 or /lights/1.json
  def show
  end

  # GET /lights/new
  def new
    @light = Light.new
  end

  # GET /lights/1/edit
  def edit
  end

  # POST /lights or /lights.json
  def create
    @light = Light.new(light_params)

    respond_to do |format|
      if @light.save
        format.html { 
          if params['commit'] == "Quick Add"
            redirect_to lights_path, notice: "Light #{@light.entity_id} was created."
          else
            redirect_to @light, notice: "Light was successfully created." 
          end
        }
        format.json { render :show, status: :created, location: @light }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lights/1 or /lights/1.json
  def update
    respond_to do |format|
      if @light.update(light_params)
        format.html { redirect_to @light, notice: "Light was successfully updated." }
        format.json { render :show, status: :ok, location: @light }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lights/1 or /lights/1.json
  def destroy
    @light.destroy
    respond_to do |format|
      format.html { redirect_to lights_url, notice: "Light was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def light_params
      params.require(:light).permit(:entity_id, :name, :room_id)
    end
end
