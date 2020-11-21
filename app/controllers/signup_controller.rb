class SignupController < ApplicationController

    def create
          user = User.new(user_params)
          if user.save
            payload = { user_id: user.id, role: user.user_type }
            session = JWTSessions::Session.new(payload: payload)
            puts session
            tokens = session.login
            response.set_cookie(JWTSessions.access_cookie,
                                value: tokens[:access],
                                httponly: true,
                                secure: Rails.env.production?)
            render json: {user: user.id, role: user.user_type, csrf: tokens[:csrf] }
          else
            render json: {errors: user.errors.full_messages.join(', ')}, status: :unprocessable_entity
          end
      end
  
    private
  
      def user_params
        params.permit(:user_type, :email, :password, :password_confirmation)
      end
    
  end
  