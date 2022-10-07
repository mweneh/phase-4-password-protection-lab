class UsersController < ApplicationController
    def create
        user = User.create!(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        end
    end

    def show
        user = User.find_by(username:params[:username])
        if user&.authenticate(password: params[:password])
            render json: user
        end
    end

    def user_params
        params.permit(:username, :password)
    end
end
