class AlbumsController < ApplicationController
  
  http_basic_authenticate_with name: "anna", password: "summer", except: [:index]
  
  def new
    @album = Album.new    
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def index
    @galleries = Album.desc(:_id).paginate :page => params[:page], :per_page => 3
  end
  
  def create
    @album = Album.new(album_params)
    
    if @album.save
      redirect_to song_path, :notice => "《#{@album.name}》创建成功"
    else
      render :new
    end
  end
  
  def update
    @album = Album.find(params[:id])
    
    if @album.update_attributes(album_params)
      redirect_to song_path, :notice => '《#{@album.name}》修改成功'
    else
      render :edit
    end
  end
  
  def album_params
    params.require(:album).permit(:name, :info)
  end
  
end