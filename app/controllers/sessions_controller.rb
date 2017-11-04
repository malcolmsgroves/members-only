class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])

      log_in @user
      remember @user
      flash[:success] = "#{@user.name} successfully logged in"
      redirect_to root_path
    else
      flash.now[:danger] = "Wrong email / password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
