class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :body
  field :is_design
  
  has_many :photos
    
  validates_presence_of :body, :title
  
end