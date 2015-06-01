class SongsController < ApplicationController
  # Execute this method before each action is executed
  before_action :set_album

  # GET /albums/:album_id/songs
  def index
    # all the albums
    @songs = @album.songs
    render json: @songs
  end

  # GET /albums/:album_id/song/:id
  def show
    @song = @album.songs.find(params[:id])
    render json: @song
  end

  # POST /albums/:album_id/songs
  def create
    @song = @album.songs.build(song_params)

    if @song.save
      render json: @song, status: :created
    else
      render json: @song.errors, status: :unprocessable_entity
    end

  end

  # DELETE /albums/:album_id/songs/:id
  def destroy
    @song = @album.songs.find(params[:id])
    @song.destroy
    head :no_content
  end

  private

  # find the album for the song/s
  def set_album
    # create an instance variable that can be accessed in
    # every action.
    @album = Album.find(params[:album_id])
  end

  def song_params
    params.require(:song).permit([:name, :comment])
  end
end
