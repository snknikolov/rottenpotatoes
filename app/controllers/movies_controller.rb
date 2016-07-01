class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.uniq.pluck(:rating)
    @selected = params[:ratings] == nil ? @all_ratings : params[:ratings].keys
    
    if params[:sort] == nil
      @movies = Movie.where({rating: @selected})
    else
      @movies = Movie.order(params[:sort])
    end
  end
  
  def show
      id = params[:id] # movie id from URI route
      @movie = Movie.find(id)
  end
  
  def new
      @movie = Movie.new
  end
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end

  def edit
      @movie = Movie.find params[:id]
  end
  
  def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
  end
  
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path  
  end
  
  def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie #{@movie.title} deleted."
      redirect_to movies_path
  end
end