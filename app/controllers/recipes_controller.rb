class RecipesController < ApplicationController

    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipes = Recipe.all
            render json: recipes, status: :created
        else
            render json: { errors: ["unauthorized"] }, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = Recipe.create(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: session[:user_id])
            if recipe.valid?
                render json: recipe, status: :created
            else
                render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
            end
            
        else
            render json: { errors: ["unauthorized"] }, status: :unauthorized
        end
    end

end
