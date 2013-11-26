class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :info
  
  has_many :songs
    
  validates_presence_of :name, :info
  
end