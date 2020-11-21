class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
    # helper_method :current_user

    private
    
        def current_user
            test = @current_user ||= User.find(payload["user_id"])
        end
        
        def not_authorized
            render json: { error: "Non autorizer" }, status: :unauthorized
        end
end
