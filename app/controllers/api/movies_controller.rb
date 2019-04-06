module Api
  class MoviesController < ActionController::API
    def index
      movies = Movie.includes(:genre)
      options = {}
      options[:include] = [:genre] if params[:include].to_s.casecmp?('genre')
      render json: MovieSerializer.new(movies, options)
    end
  end
end
