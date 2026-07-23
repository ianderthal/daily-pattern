class EventsController < ApplicationController
  def index
    @event = Event.new(date: Date.current, time: Time.current)
    @recent_events = Event.order(date: :desc, time: :desc).limit(20)
  end

  def new
    @event = Event.new(date: Date.current, time: Time.current)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path, notice: "Event logged."
    else
      @recent_events = Event.order(date: :desc, time: :desc).limit(20)
      render :index, status: :unprocessable_entity
    end
  end

  def heatmap_data
    counts = Event.group(:date).count
    render json: counts.sort.map { |date, value| { date: date.to_s, value: value } }
  end

  private

  def event_params
    params.require(:event).permit(:date, :time, :comment)
  end
end
