class Poem
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :body
  field :url
  field :is_poem, :type => Mongoid::Boolean, :default => true
  
  validates_presence_of :title, :body
  
end