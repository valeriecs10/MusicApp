class AlbumsController < ApplicationController
  def new
    @band_id = params[:band_id].to_i
    render :new
  end
end