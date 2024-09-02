# filename: app/controllers/api/v1/sessions_controller.rb

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token # Only if you're not using CSRF protection

      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: { message: 'Logged in successfully', user: user }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        session.delete(:user_id)
        render json: { message: 'Logged out successfully' }, status: :ok
      end
    end
  end
end
