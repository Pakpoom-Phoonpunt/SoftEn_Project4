class MoviesController < ApplicationController
    def index
        # @movies = Movie.all()
        # @movies = Movie.order("title ASC")
        @movies = Movie.all().sort_by{|mov| mov.title}
    end

    def show
        begin
            @movie = Movie.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            flash[:notice] = " No movie with the given ID could be found."
            redirect_to action:"index"
        end
    end

    def new
        @movie = Movie.new()
    end
    def create
        params.require(:movie)
        new_movie  = params[:movie].permit(:title,:rating,:release_date,:description)
        # puts new_movie
        @movie = Movie.create!(new_movie)
        
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movie_path(@movie)
    end
    
    def edit
        @movie = Movie.find(params[:id])
    end
      
    def update
        @movie = Movie.find(params[:id])
        # params.require(:movie)
        @movie.update!(params[:movie].permit(:title,:rating,:release_date,:description))
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy()
        flash[:notice] = "#{@movie.title} was Deleted."
        redirect_to movies_path
    end

    # private
    # def movies_params
    #     params[:movie].permit(:title,:rating,:release_date)
    # end
end