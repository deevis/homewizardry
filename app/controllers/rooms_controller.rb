class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy say tell_joke toggle_say_service]

  # GET /rooms or /rooms.json
  def index
    @entities = NodeRedService.get(:entities)
    @q = Room.ransack(params[:q])
    @rooms = @q.result
  end

  def say
    message = @room.say(params[:say][:message])
    redirect_to @room, notice: "Said: #{message}"
  end

  def tell_joke
    joke_type = params[:joke_type]
    @message = @room.say(message_type: joke_type)
    redirect_to @room, notice: "Said: #{@message}"
  end

  # params
  #           enabled: true|false
  #      service_name: the name of the service
  def toggle_say_service
    service_name = params['service_name']
    enabled = params['enabled'].downcase == 'true'
    if enabled && !@room.say_services.index(service_name)
      @room.say_services << service_name
      @room.save!
    elsif !enabled && @room.say_services.index(service_name)
      @room.say_services.delete(service_name)
      @room.save!
    end
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :door_contact_id, :speaker_id, :cooldown_seconds, :quiet_hours)
    end
end
