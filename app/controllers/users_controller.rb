class UsersController < ApplicationController
  respond_to :html
  
  def new
    @user = User.new
  end

  def create
    @user = User.create :type => params[:user][:type]
    if params[:user][:type] == 'Programmer'
      @programmer = Programmer.create! :github_username => params[:user][:github_username], :lastfm_username => params[:user][:lastfm_username]
      @user.programmer = @programmer
      @programmer.user = @user
    elsif params[:user][:type] == 'Designer'
      designer = Designer.create! :dribbble_username => params[:user][:dribbble_username], :lastfm_username => params[:user][:lastfm_username]
      @user.designer = @designer
      @designer.user = @user
    end
    if @user.save!
      cookies.permanent[:last_product_id] = @product.id
      redirect_to @user
    end
  end
  
  def show
    @user = User.find params[:id]
  end

end
