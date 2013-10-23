class Poem
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :body
  
  validates_presence_of :title, :body
  
end