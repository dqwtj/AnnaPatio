class HomeController < ApplicationController
  
  def patio
    
  end
  
  def music
    @first = Album.first
    @lastest = Album.last
  end
  
  def live
    @first = Album.first
    @lastest = Album.last
  end
  
  def vedio
    @first = Album.first
    @lastest = Album.last
  end
  
end
