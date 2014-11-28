class HomeController < ApplicationController
  
  def patio
    
  end
  
  def music
    @first = Album.find_by(name: "晴日共剪窗")
    @lastest = Album.find_by(name: "最新单曲")
    @second = Album.find_by(name: "诗遇上歌")
  end
  
  def live
    @first = Album.find_by(name: "晴日共剪窗")
    @lastest = Album.find_by(name: "最新单曲")
    @second = Album.find_by(name: "诗遇上歌")
  end
  
  def video
    @first = Album.find_by(name: "晴日共剪窗")
    @lastest = Album.find_by(name: "最新单曲")
    @second = Album.find_by(name: "诗遇上歌")
  end
  
  def about
    @first = Album.find_by(name: "晴日共剪窗")
    @lastest = Album.find_by(name: "最新单曲")
    @second = Album.find_by(name: "诗遇上歌")
  end
  
end
