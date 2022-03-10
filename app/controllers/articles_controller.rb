class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :edit_perm_check, only: [:update, :edit, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(validate_params)
    @article.user = current_user
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

  def edit_perm_check
    if current_user != @article.user && current_user.admin < 2
      flash[:alert] = "you do not have permission to edit this article"
      redirect_to @article
    end
  end

end
