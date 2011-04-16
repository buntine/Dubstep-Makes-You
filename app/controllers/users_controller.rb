class UsersController < ApplicationController
  respond_to :html
  
  def index
    @users = User.find :all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.create! :lastfm_username => params[:user][:lastfm_username]
    if params[:user][:type] == 'Programmer'
      @user.programmer = Programmer.create! :github_username => params[:user][:github_username]
    elsif params[:user][:type] == 'Designer'
      @user.designer = Designer.create! :dribbble_username => params[:user][:dribbble_username]
    end
    redirect_to :action => 'show'
  end
  
  def show
    @user = User.find params[:id]
  end

end
