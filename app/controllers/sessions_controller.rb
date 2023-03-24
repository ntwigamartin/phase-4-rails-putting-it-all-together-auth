class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :ok
        else
            render json: { errors: ['invalid username', 'invalid password'] }, status: :unauthorized
        end
    end

    def destroy
        user = User.find_by(id: session[:user_id])
        if user
            session.delete(:user_id)
            head :no_content
        else
            render json: { errors: ['Unauthorized', 'Failed'] }, status: :unauthorized
        end
    end
end
