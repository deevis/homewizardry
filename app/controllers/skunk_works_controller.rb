class SkunkWorksController < ApplicationController


  # Show all the skunkwork options
  def index
  end

  def say_randomly
    room_ids = params[:room_ids].split(",")
    message = params[:message]
    delay = [params[:delay].to_i, 0.1].max
    count = 100

    Thread.new do
        count.times do 
            r = Room.find(room_ids.sample)
            r.say message
            sleep delay
        end
    end
    
    redirect_to skunk_works_path, notice: "I'm saying #{message} a bunch"
  end
end