class NotesController < ApplicationController
  def new
    @note = Note.new
    @track = Track.find_by_id(params[:track_id])
    render :new
  end

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    note.save
    redirect_to track_url(note.track)
  end

  def destroy
    note = Note.find_by_id(params[:id])
    track = note.track
    if note.user_id != current_user.id
      render text: "Users can only delete their own notes", status: 403
    else
      note.destroy
      redirect_to track_url(track)
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :user_id, :track_id)
  end
end