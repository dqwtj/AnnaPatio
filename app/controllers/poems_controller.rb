class PoemsController < ApplicationController
  
  def new
    @poem = Poem.new
  end
  
  def edit
    @poem = Poem.find(params[:id])
  end
  
  def index
    @poems = Poem.desc(:created_at).paginate :page => params[:page], :per_page => 7
  end
  
  def show
    @poem = Poem.find(params[:id])
    @poemLeft = Poem.where(:_id.lt => params[:id]).last();
    @poemRight = Poem.where(:_id.gt => params[:id]).first();
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
    params.require(:poem).permit(:title, :body, :is_poem)
  end
  
end