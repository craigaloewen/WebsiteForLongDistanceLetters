module SessionsHelper
    def log_in(jar)
        session[:jar_id] = jar.id
    end

    def admin_log_in(jar)
        session[:admin_jar_id] = jar.id
        log_in(jar)
    end

    def check_admin_access(jar)
        if !admin_logged_in? || !logged_in?
            redirect_to jar_admin_login_path(jar)
        end
    end

    def check_jar_access(jar)
        if jar.is_secured
            if !logged_in?
                redirect_to jar_login_path(jar)
            end
        end
    end

    def current_jar
        @current_jar ||= Jar.find_by(id: session[:jar_id])
    end

    def current_admin_jar
        @current_admin_jar ||= Jar.find_by(id: session[:admin_jar_id])
    end

    # Returns true if the jar is logged in, false otherwise.
    def logged_in?
        !current_jar.nil?
    end

    def admin_logged_in?
        !current_admin_jar.nil?
    end

    def log_out
        session.delete(:jar_id)
        @current_jar = nil
    end

    def admin_log_out
        session.delete(:admin_jar_id)
        @current_admin_jar = nil
        log_out
    end
end