class DoorMessagesController < ApplicationController
  before_action :set_door_message, only: %i[ show edit update destroy ]

  # GET /door_messages or /door_messages.json
  def index
    @q = DoorMessage.ransack(params[:q])
    @door_messages = @q.result
  end

  # GET /door_messages/1 or /door_messages/1.json
  def show
  end

  def get_message
    speaker_id = "media_player.everywhere"
    if (dci = params[:entity_id]).present?
      room = Room.find_by(door_contact_id: dci)
      if (room.quiet_hours?) ||  (room.cooling_down?)
        message = "__COOLDOWN__"
      else
        message = room.get_message
        speaker_id = room.speaker_id
      end
    else
       message = DoorMessage.all.sample.message
    end
    render json: {message: message, speaker_id: speaker_id}
  end

  # GET /door_messages/new
  def new
    @door_message = DoorMessage.new
  end

  # GET /door_messages/1/edit
  def edit
  end

  # POST /door_messages or /door_messages.json
  def create
    @door_message = DoorMessage.new(door_message_params)

    respond_to do |format|
      if @door_message.save
        format.html { redirect_to @door_message, notice: "Door message was successfully created." }
        format.json { render :show, status: :created, location: @door_message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @door_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /door_messages/1 or /door_messages/1.json
  def update
    respond_to do |format|
      if @door_message.update(door_message_params)
        format.html { redirect_to @door_message, notice: "Door message was successfully updated." }
        format.json { render :show, status: :ok, location: @door_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @door_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /door_messages/1 or /door_messages/1.json
  def destroy
    @door_message.destroy
    respond_to do |format|
      format.html { redirect_to door_messages_url, notice: "Door message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_door_message
      @door_message = DoorMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def door_message_params
      params.require(:door_message).permit(:message, :room_id)
    end
end
