class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.uniq.pluck(:rating)

    # Update session selected ratings if the ratings query is updated.
    if session[:ratings] != params[:ratings] && params[:ratings] != nil
      session[:ratings] = params[:ratings] 
    end
    # Update session sort if the sort query is updated.
    if session[:sort] != params[:sort] && params[:sort] != nil
      session[:sort] = params[:sort]
    end

    # If anythings is missing from query params and is available in session, get it from session.
    if params[:ratings] == nil && params[:sort] == nil && session[:ratings] != nil
      redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    elsif params[:ratings] == nil && session[:ratings] != nil
      redirect_to movies_path(:sort => params[:sort], :ratings => session[:ratings])
    elsif params[:sort] == nil && session[:sort] != nil
      redirect_to movies_path(:sort => session[:sort], :ratings => params[:ratings])
    end
    @selected = params[:ratings] == nil ? @all_ratings : params[:ratings].keys

    @movies = Movie.order(params[:sort]).where({rating: @selected})
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