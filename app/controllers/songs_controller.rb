class SongsController < ApplicationController
  
  def new
    @album = Album.find params[:album_id]
    @song = @album.songs.new    
  end
  
  def edit
    @album = Album.find params[:album_id]
    @song = @album.songs.find(params[:id])
    @policy = Base64.encode64({:bucket => 'annapatio-photo', :expiration => (Time.now().to_i + 3600), 'save-key' => "/photos/{filemd5}{.suffix}","allow-file-type" =>"jpg,jpeg,gif,png","content-length-range" => "0,10240000", "return-url" => song_photo_url(@song)}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'LgCKvQBvb6N7blZe0Xluhr2RCB0=')
  end
  
  def show
    @album = Album.find params[:album_id]
    @song = @album.songs.find(params[:id])
    @left = @album.songs.where(:index.lt => @song.index).last()
    @right = @album.songs.where(:index.gt => @song.index).first()
  end 
  
  def create
    @album = Album.find params[:album_id]
    @song = @album.songs.new(song_params)
    
    if @song.save
      redirect_to music_path, :notice => "《#{@song.name}》创建成功"
    else
      render :new
    end
  end
  
  def update
    @song = Song.find(params[:id])
    
    if @song.update_attributes(song_params)
      redirect_to music_path, :notice => '《#{@song.name}》修改成功'
    else
      render :edit
    end
  end
  
  def song_params
    params.require(:song).permit(:name, :info, :url, :lyrics, :index)
  end
  
end