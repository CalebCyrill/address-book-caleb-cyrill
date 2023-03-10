class UsersController < ApplicationController
  # instantiates new user
  before_action :set_user, only: %i[ destroy ]
  protect_from_forgery with: :null_session
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    # stores saved user id in a session
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully created account'
    else
      render :new
    end
  end

  def user_params
    # strong parameters
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end