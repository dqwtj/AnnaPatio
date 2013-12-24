# -*- encoding : utf-8 -*-
class WeixinsController < ApplicationController
  before_filter :check_weixin_legality

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
    end
    if (params[:xml][:MsgType] == "event") && (params[:xml][:Event] == "subscribe")
      render "welcome", :formats => :xml
    end
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = ["sumersmile", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end