module ExternalApi
  class MoviesController < ApplicationController
    def index
      render json: MovieApi.movie(params[:title])
    end
  end
end
