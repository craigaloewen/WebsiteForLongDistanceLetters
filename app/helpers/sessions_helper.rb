module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if @user.nil?
            @current_user ||= User.find_by(id: session[:user_id])
        else
            @current_user = @user
        end
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
