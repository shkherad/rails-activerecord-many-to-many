class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to albums_path, notice: "Album #{@album.name} created "
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to albums_path, notice: "You have updated the album #{@album.name}"
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_path, alert: 'Album deleted'
  end

  private

  def album_params
    params.require(:album).permit([:name, :genre])
  end

  def set_album
    @album = Album.find(params[:id])
  end

end
