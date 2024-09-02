# filename: app/controllers/api/v1/users_controller.rb

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token # Only if you're not using CSRF protection

      def create
        user = User.new(user_params)

        if user.save
          render json: { message: 'User created successfully', user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :username, :password)
      end
    end
  end
end


# {
#   "user": {
#     "email": "user@example.com",
#     "username": "johndoe",
#     "password": "securepassword"
#   }
# }
