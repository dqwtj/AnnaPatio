class PoemsController < ApplicationController
  
  http_basic_authenticate_with name: "anna", password: "summer", except: [:index, :show]
  
  def new
    @poem = Poem.new
  end
  
  def edit
    @poem = Poem.find(params[:id])
  end
  
  def index
    @poems = Poem.desc(:created_at).paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @poem = Poem.find(params[:id])
    @poemLeft = Poem.where(:created_at.gt => @poem.created_at).first();
    @poemRight = Poem.where(:created_at.lt => @poem.created_at).last();
  end
  
  def create
    @poem = Poem.new(poem_params)
    
    if @poem.save
      redirect_to poem_path(@poem), :notice => "《#{@poem.title}》创建成功"
    else
      render :new
    end
  end
  
  def update
    @poem = Poem.find(params[:id])
    
    if @poem.update_attributes(poem_params)
      redirect_to poem_path(@poem), :notice => '比较器修改成功'
    else
      render :edit
    end
  end
  
  def poem_params
    params.require(:poem).permit(:title, :body, :is_poem, :url)
  end
  
end