class SessionsController < ApplicationController
   
    def new
        
    end

    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to teams_path
        else
            flash[:alert] = "Something went wrong, please try again."
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to teams_path
    end

end