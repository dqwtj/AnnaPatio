class PhotosController < ApplicationController
  
  def index
    
    if params[:code] && params[:url]
      @code = params[:code].to_i
      if @code == 200
        @url = params[:url]
      end
      @message = params[:message]
    end
    if @url
      if params[:gallery_id]
        @gallery = Gallery.find(params[:gallery_id])
        @photo = @gallery.photos.new(:base_url => @url)
        if @photo.save
          redirect_to edit_gallery_path(@gallery), :notice => "照片创建成功"
        else
          redirect_to edit_gallery_path(@gallery), :notice => "照片创建失败"
        end
      else
        @song = Song.find params[:song_id]
        @song.photo = Photo.new(:base_url => @url)
        if @song.save
          redirect_to edit_album_song_path(@song.album, @song), :notice => "照片创建成功"
        else
          redirect_to edit_album_song_path(@song.album, @song), :notice => "照片创建失败"
        end
      end  
    else
      redirect_to edit_gallery_path(@gallery), :notice => "照片创建失败"
    end
  end
  
  def destroy
    @gallery = Gallery.find params[:gallery_id]
    @photo = Photo.find params[:id]
    
    @photo.destroy
    redirect_to edit_gallery_path(@gallery)
  end
  
end