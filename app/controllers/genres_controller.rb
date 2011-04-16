class GenresController < ApplicationController
  def index
    @genres = Genre.where(:parent_id => nil)
  end

  def show
    @genre = Genre.find params[:id]
  end

end
