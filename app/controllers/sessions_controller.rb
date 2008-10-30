class SessionsController < ApplicationController

  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default root_path
      flash[:notice] = "Logged in successfully"
    else
      @email       = params[:email]
      @remember_me = params[:remember_me]
      render :action => :new
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = 'Auf Wiedersehen, sie sind nun ausgeloggt.'
    redirect_back_or_default root_path
  end
end
