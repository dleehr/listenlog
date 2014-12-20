class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :edit, :update, :destroy, :start_listening, :finish_listening]
  # GET /recordings
  # GET /recordings.json
  def index
    @recordings = Recording.all
    if params[:concert]
      @recordings = @recordings.by_concert(params[:concert])
    end
    if params[:listening]
      @recordings = @recordings.by_listening(params[:listening])
    end
  end

  # GET /recordings/1
  # GET /recordings/1.json
  def show
  end

  # GET /recordings/new
  def new
    @recording = Recording.new
  end

  # GET /recordings/1/edit
  def edit
  end

  # POST /recordings
  # POST /recordings.json
  def create
    @recording = Recording.new(recording_params)

    respond_to do |format|
      if @recording.save
        format.html { redirect_to @recording, notice: 'Recording was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recording }
      else
        format.html { render action: 'new' }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordings/1
  # PATCH/PUT /recordings/1.json
  def update
    respond_to do |format|
      if @recording.update(recording_params)
        format.html { redirect_to @recording, notice: 'Recording was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordings/1
  # DELETE /recordings/1.json
  def destroy
    @recording.destroy
    respond_to do |format|
      format.html { redirect_to recordings_url }
      format.json { head :no_content }
    end
  end

  # POST /recordings/1/start_listening
  # POST /recordings/1/start_listening.json
  def start_listening
    listen_event = @recording.start_listening(params[:note])
    respond_to do |format|
      if listen_event
        format.html { redirect_to @recording, notice: 'Started listening' }
        format.json { render json:listen_event, status: :created }
      else
        format.html { redirect_to @recording, notice: 'Unable to start listening.' }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /recordings/1/finish_listening
  # POST /recordings/1/finish_listening.json
  def finish_listening
    listen_event = @recording.finish_listening(params[:note])
    respond_to do |format|
      if listen_event
        format.html { redirect_to @recording, notice: 'Finished listening' }
        format.json { render json:listen_event, status: :created }
      else
        format.html { redirect_to @recording, notice: 'Unable to finish listening.' }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_params
      params.require(:recording).permit(:title, :concert_id)
    end
end
