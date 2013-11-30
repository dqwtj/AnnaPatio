class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :body
  field :is_design, :type => Mongoid::Boolean, :default => false
  
  has_many :photos
    
  validates_presence_of :body, :title
  
  scope :designs, -> { where(:is_design => true) }
  scope :galleries, -> { where(:is_design => false) }
  
end