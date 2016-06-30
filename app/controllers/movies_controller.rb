class MoviesController < ApplicationController
  def index
    #@movies = Movie.all 
    #byebug
    if params[:sort] == nil
      @movies = Movie.order(:title)
    #elsif params[:release_date] != nil
      #@movies = Movie.order(:release_date)
    else
      #@movies = Movie.all
      @movies = Movie.order(params[:sort])
    end
    #@movies = Movie.order(params)
    #@movies = Movie.order(params)
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