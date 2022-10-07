class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username)
            if user&.authenticate(password: params[:password)
                render json: { message:"User logged in successfully"}, status: :created
            else
                render json: { message:"Invalid username or password"}, status: :unauthorized
            end
    end

    def destroy
        session.delete :user_id
        
    end
end
