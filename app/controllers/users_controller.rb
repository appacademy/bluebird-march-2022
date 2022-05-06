class UsersController < ApplicationController
  def index #all entries  
    @users = User.all 
    # render json: users
    render :index
  end

  def show #singular entry
    @user = User.find(params[:id])
    render :show
  end

  # when writing the #new method, remember to write #create 
  def new 
    @user = User.new 
    render :new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      redirect_to user_url(@user.id)
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  # #edit and #update
  def edit # renders the form
    @user = User.find(params[:id])
    render :edit
  end

  def update # processes the form
    @user = User.find(params[:id])
    if @user.update(user_params)
      # redirect_to user_url(@user), can use both 
      render :show
    else 
      render json: @user.errors.full_messages, status: 422
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:username, :email, :age, :political_affiliation, :password)
  end
end
