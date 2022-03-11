class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :edit_perm_check, only: [:edit, :update, :destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def show
    @articles = @user.articles
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the AlphaBlog #{@user.username}, your sign up was successful"
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Account update successful"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    session[:user_id] = nil if @user == current_user
    @user.destroy
    flash[:notice] = "Account and associated article have been deleted"
    redirect_to articles_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def edit_perm_check
    if current_user != @user && current_user.admin < 2
      flash[:alert] = "You can only edit your own account"
      redirect_to @user
    end
  end
end
