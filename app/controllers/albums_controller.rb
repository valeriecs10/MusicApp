class AlbumsController < ApplicationController
  def new
    @album = Album.new
    @band_id = params[:band_id].to_i
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else 
      log_flash_messages
      redirect_to new_band_album_url(@album.band_id), info: "Album could not be saved."
    end
  end

  def show
    @album = Album.find_by_id(params[:id])
    render :show
  end

  def edit
    @album = Album.find_by_id(params[:id])
    render :edit
  end

  def update
    @album = Album.find_by_id(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      log_flash_messages
      redirect_to edit_album_url(@album), info: "Album could not be updated."
    end
  end

  def destroy
    @album = Album.find_by_id(params[:id])
    band_id = @album.band_id
    if @album.destroy
      redirect_to band_url(band_id)
    else
      redirect_to album_url(@album), info: "Album could not be deleted."
    end
  end

  private

  def log_flash_messages
    @album.errors.full_messages.each do |msg|
      flash_message(:alert, msg)
    end
  end

  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end
end