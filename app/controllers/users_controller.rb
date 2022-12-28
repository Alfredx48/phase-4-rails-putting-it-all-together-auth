class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  #! :authorize and @current_user are in application controller

  #* How to create an user and same user id to session hash and render
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  #* Keeps the user loggin in by finding by the user_id session hash
  def show
    render json: @current_user
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end
end
