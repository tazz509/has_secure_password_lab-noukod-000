class UsersController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new users_params

    if @user.save
      redirect_to controller: 'sessions', action: :new
      session[:user_id] = @user.id
    else
      flash[:alert] = 'Failed creating your account'
      # flash[:error] = @user.errors.messages
      redirect_to controller: 'users', action: :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
