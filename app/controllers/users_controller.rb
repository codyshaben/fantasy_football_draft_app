class UsersController < ApplicationController
  def new
    if current_user
      redirect_to '/teams'
    end
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      Team.create(name: "Broncos", user_id: @user[:id])
      flash[:message] = "User has been succesfully created!"
      session[:user_id] = @user.id
      redirect_to teams_path
    else 
      flash[:alert] = "Username already exists."
      render :new
    end

    def home
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

end
