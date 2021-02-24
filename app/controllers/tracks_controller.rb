class TracksController < ApplicationController
  def new
    @track = Track.new
    @album_id = params[:album_id].to_i
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else 
      log_flash_messages
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  def show
    @track = Track.includes(:album).find_by_id(params[:id])
    render :show
  end

  def destroy
    @track = Track.find_by_id(params[:id])
    album_id = @track.album_id
    if @track.destroy
      redirect_to album_url(album_id)
    else
      redirect_to album_url(album_id), alert: "Couldn't delete track"
    end
  end

  def edit
    @track = Track.find_by_id(params[:id])
    @album_id = @track.album_id
    render :edit
  end 

  def update 
    track = Track.find_by_id(params[:id])
    if track.update_attributes(track_params)
      redirect_to track_url(track)
    else
      log_flash_messages
      redirect_to edit_track_url(track)
    end
  end

  private

  def log_flash_messages
    @track.errors.full_messages.each do |msg|
      flash_message(:alert, msg)
    end
  end

  def track_params
    params.require(:track).permit(:title, :ord, :bonus, :album_id, :lyrics)
  end
end