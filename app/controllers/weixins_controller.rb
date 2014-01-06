# -*- encoding : utf-8 -*-
class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #before_filter :check_weixin_legality

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      if params[:xml][:Content] =~ /[新][年][好]/
        render "newyear", :formats => :xml
      end
      @song = Song.where(:name => params[:xml][:Content]).first
      if @song
        render "song", :formats => :xml
      end
      @poem = Poem.where(:title => params[:xml][:Content]).first
      if @poem && @poem.url
        render "poem", :formats => :xml
      end
    end
    if (params[:xml][:MsgType] == "event") && (params[:xml][:Event] == "subscribe")
      render "welcome", :formats => :xml
    end
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end