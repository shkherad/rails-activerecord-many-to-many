module SongsHelper

  def show_songs(album)
    if(album.songs.empty?)
      content_tag(:strong, "No Songs")
    else
      link_to("#{album.songs.count} songs in this album", album_songs_path(album))
    end
  end
end
