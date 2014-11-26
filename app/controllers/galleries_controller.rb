class GalleriesController < ApplicationController
  
  http_basic_authenticate_with name: "anna", password: "summer", except: [:index, :show, :design]
  
  def new
    @gallery = Gallery.new    
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
    @policy = Base64.encode64({:bucket => 'annapatio-photo', :expiration => (Time.now().to_i + 3600), 'save-key' => "/photos/{filemd5}{.suffix}","allow-file-type" =>"jpg,jpeg,gif,png","content-length-range" => "0,10240000", "return-url" => gallery_photos_url(@gallery)}.to_json).gsub("\n","")
    @signature = Digest::MD5.hexdigest(@policy+'&'+'LgCKvQBvb6N7blZe0Xluhr2RCB0=')
  end
  
  def index
    @galleries = Gallery.galleries.desc(:_id).paginate :page => params[:page], :per_page => 3
  end
  
  def list
    @galleries = Gallery.all.desc(:_id).paginate :page => params[:page], :per_page => 10
  end
  
  def design
    @designs = Gallery.designs.desc(:_id).paginate :page => params[:page], :per_page => 3
  end
  
  def create
    @gallery = Gallery.new(gallery_params)
    
    if @gallery.save
      redirect_to galleries_path, :notice => "《#{@gallery.title}》创建成功"
    else
      render :new
    end
  end
  
  def update
    @gallery = Gallery.find(params[:id])
    
    if @gallery.update_attributes(gallery_params)
      redirect_to galleries_path, :notice => '《#{@gallery.title}》修改成功'
    else
      render :edit
    end
  end
  
  def destroy 
    @gallery = Gallery.find(params[:id])
    
    @gallery.destroy
    redirect_to galleries_path, :notice => '《#{@gallery.title}》删除成功'
  end
  
  def gallery_params
    params.require(:gallery).permit(:title, :body, :is_design)
  end
  
end