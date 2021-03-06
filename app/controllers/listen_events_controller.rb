class ListenEventsController < ApplicationController
  before_action :set_recording
  before_action :set_listen_event, only: [:show, :edit, :update, :destroy]
  # GET /listen_events
  # GET /listen_events.json
  def index
    @listen_events = ListenEvent.by_recording(@recording)
  end

  # GET /listen_events/1
  # GET /listen_events/1.json
  def show
  end

  # GET /listen_events/last
  # GET /listen_events/last.json
  def last
    @listen_event = @recording.listen_events.last
    render :show
  end

  # GET /listen_events/new
  def new
    @listen_event = ListenEvent.new(recording_id:@recording.id)
  end

  # GET /listen_events/1/edit
  def edit
  end

  # POST /listen_events
  # POST /listen_events.json
  def create
    @listen_event = ListenEvent.new(listen_event_params)

    respond_to do |format|
      if @listen_event.save
        format.html { redirect_to recording_listen_event_path(@recording, @listen_event), notice: 'Listen event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listen_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @listen_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listen_events/1
  # PATCH/PUT /listen_events/1.json
  def update
    respond_to do |format|
      if @listen_event.update(listen_event_params)
        format.html { redirect_to recording_listen_event_path(@recording, @listen_event), notice: 'Listen event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listen_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listen_events/1
  # DELETE /listen_events/1.json
  def destroy
    @listen_event.destroy
    respond_to do |format|
      format.html { redirect_to recording_listen_events_url(@recording)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listen_event
      @listen_event = @recording.listen_events.find(params[:id])
    end

    def set_recording
      @recording = Recording.find(params[:recording_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listen_event_params
      params.require(:listen_event).permit(:type, :recording_id, :note)
    end
end
