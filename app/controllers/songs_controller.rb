class SongsController < ApplicationController

  # set the parent instance and parent resource name
  # for all actions
  before_action :set_parent

  # set the song parent instance for some actions
  before_action :set_song, only: [:show,:edit,:update, :destroy]

  def index
    @songs = @parent.songs
  end

  def show
  end

  def new
    @song = @parent.songs.new
  end

  def create
    @song = @parent.songs.new(song_params)

    if @song.save
      redirect_to send("#{@parent_resource}_songs_path",@parent), notice: "You've created a new Song for an #{@parent_resource}"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @song = @parent.songs.find(params[:id])

    if @song.update(song_params)
      redirect_to send("#{@parent_resource}_songs_path",@parent), notice: 'Song was succesfully updated.'
    else
      render :new
    end
  end

  private
  def set_parent
    logger.debug "invoking set_song"
    parent_resources = %w{ album artist}
    if @parent_resource = parent_resources.detect { |pk| params["#{pk}_id"].present? }
      logger.debug "parent resource is #{@parent_resource}"
      @parent = @parent_resource.camelize.constantize.find(params[:"#{@parent_resource}_id"])
    end
  end

  def set_song
    logger.debug "invoking set_song"
    @song = @parent.songs.find(params[:id])
  end

  def song_params
    # handle $ sign in the input, just remove it if present
    params[:song][:price] = params[:song][:price].gsub('$','')
    params.require(:song).permit(:title, :duration, :price)
  end
end
