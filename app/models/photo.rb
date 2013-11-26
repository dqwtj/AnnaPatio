class Photo
  include Mongoid::Document
  
  field :caption
  field :base_url
  
  belongs_to :gallery
  belongs_to :song
    
  validates_presence_of :base_url
  
  def mobile
    self.base_url.blank? ? "#" : self.upyun_url+self.base_url+"!mobile"
  end
  
  def song
    self.base_url.blank? ? "#" : self.upyun_url+self.base_url+"!song"
  end
  
  def preview
    self.base_url.blank? ? "#" : self.upyun_url+self.base_url+"!preview"
  end
  
  protected
    def upyun_url
      "http://annapatio-photo.b0.upaiyun.com"
    end

end
