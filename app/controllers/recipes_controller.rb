class RecipesController < ApplicationController
  def index
    render json: Recipe.all, includes: :users
  end

  def create
    # user = User.find_by(id: session[:user_id])
    # recipe = user.recipes.create!(recipe_params)
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:user_id, :title, :instructions, :minutes_to_complete)
  end
end
