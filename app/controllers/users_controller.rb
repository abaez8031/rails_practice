class UsersController < ApplicationController

  def index
    if params[:query]
      @users = User.find("name iLIKE '%#{params[:query]}%'")
    else
      @users = User.all
    end
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

end