class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create
  #! :authorize is in application controller

  #* finds the user by the username params and checks if the user && user.authenticate
  #* .authenticate is a BCRYPT method that will hash the password with the salt and match
  #* it with the saved password in our database, if it passes we save our user to our sessions
  #* else we render our error
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end
