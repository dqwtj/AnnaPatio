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
  
  def video
    @first = Album.first
    @lastest = Album.last
  end
  
  def about
    @first = Album.first
    @lastest = Album.last
  end
  
end
