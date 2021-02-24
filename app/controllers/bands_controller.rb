class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.includes(:albums).find_by_id(params[:id])
  end 

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url
    else
      log_flash_messages
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def update
    @band = Band.find_by(id: params[:id])

    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      log_flash_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find_by_id(params[:id])
    if @band.destroy
      redirect_to bands_url
    else
      redirect_to band_url(@band)
    end
  end

  private

  def log_flash_messages
    @band.errors.full_messages.each do |msg|
      flash_message(:alert, msg)
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end 
end