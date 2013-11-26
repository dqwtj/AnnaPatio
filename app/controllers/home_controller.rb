class HomeController < ApplicationController
  
  def patio
    
  end
  
  def music
    @album = Album.first
    @lastest = Album.last
  end
  
end
