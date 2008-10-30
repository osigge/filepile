class UsersController < ApplicationController

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.save if @user and @user.valid?
    success = @user and @user.valid?
    if success and @user.errors.empty?
      redirect_back_or_default root_path
      flash[:notice] = "Der Benutzer wurde angelegt und die Zugangsdaten per E-Mail an #{@user.email} versendet."
    else
      flash[:error]  = 'Fehler beim Anlegen des Benutzers'
      render :action => :new
    end
  end
end
