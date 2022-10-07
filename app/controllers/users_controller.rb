class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
before_action :authorize, only: [:show]

    def create
        user = User.create!(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        end
    end

    def show
        user = User.find ( session[:user_id])
        render json: user
      end
    private

    def render_not_found
        render json: { error: "User not found" }, status: 404
    end

    def render_invalid(exception)
        render json: { error: exception.record.errors }, status: 422
    end

    def user_params
        params.permit(:username, :password,:password_confirmation)
    end


    def authorize
      render json:{errors: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end
end
