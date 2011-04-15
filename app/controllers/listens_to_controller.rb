class ListensToController < ApplicationController
  responds_to :html
  
  def index
  end
  
  def new
    @user = Programmer.new
  end
  
  def create
    if params[:user].try[:type] == 'programmer'
      @user = Programmer.create(params[:user])
    elsif
      @user = Designer.create(params[:user])
    end
    respond_with @user
  end
end