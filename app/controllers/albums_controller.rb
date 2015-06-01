class AlbumsController < ApplicationController

  # GET /albums
  def index
    # all the albums
    @albums = Album.all
    render json: @albums
  end

  # GET /albums/:id
  def show
    # find one Album by id
    @album = Album.find(params[:id])
    render json: @album
  end

  # POST /albums
  def create
    @album = Album.new(album_params)
    if @album.save
      render json: @album, status: :created, location: albums_url
    else
      render json: @album.errors, status: :unprocessable_entity
     end
  end

  # PATCH /albums/:id
  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      head :no_content
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/:id
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    head :no_content
  end

  private
   def album_params
    params.require(:album)
      .permit(:name, :rating, :desc, :length)
  end
end
