class SongsController < ApplicationController

  # set the album instance for all actions
  before_action :set_album

  # set the song album instance for some actions
  before_action :set_song, only: [:show,:edit,:update, :destroy]

  # GET /albums/:album_id/
  def index
    @songs = @album.songs
  end

  # GET /albums/:album_id/songs/:id
  def show
  end

  # GET /albums/:album_id/songs/new
  def new
    @song = @album.songs.new
  end

  # POST /albums/:album_id/songs/:id/edit
  def create
    @song = @album.songs.new(song_params)

    if @song.save
      redirect_to album_songs_path(@album), notice: "You've created a new Song"
    else
      render :new
    end
  end

  # GET /albums/:album_id/edit/songs/:id/edit
  def edit
  end

  # PATCH/PUT /albums/:album_id/songs/:id
  def update
    @song = @album.songs.find(params[:id])

    if @song.update(song_params)
      redirect_to album_songs_path(@album), notice: 'Song was succesfully updated.'
    else
      render :new
    end
  end

  private
  def set_album
    logger.debug "invoking set_album"
    @album = Album.find(params[:album_id])
  end

  def set_song
    logger.debug "invoking set_song"
    @song = @album.songs.find(params[:id])
  end

  def song_params
    # handle $ sign in the input, just remove it if present
    params[:song][:price] = params[:song][:price].gsub('$','')
    params.require(:song).permit(:title, :duration, :price)
  end
end
