class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :info
  field :url
  field :index
  field :lyrics
  
  has_one :photo
  belongs_to :album
    
  validates_presence_of :name, :info, :url
  
end