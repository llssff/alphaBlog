class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(validate_params)
    if @article.save
      flash[:notice] = "Shit worked"
      redirect_to article_path(@article.id)
    else
      render 'new' #link to new_html_erb
    end
  end

  def edit

  end

  #patch and put requests
  def update
    if @article.update(validate_params)
      flash[:notice] = "Shit updated"
      redirect_to article_path(@article.id)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end


  private
  def set_article
    @article = Article.find(params[:id])
  end

  def validate_params
    params.require(:article).permit(:title, :description)
  end

end
