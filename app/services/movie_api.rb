class MovieApi
  include HTTParty
  base_uri "https://pairguru-api.herokuapp.com"

  def self.movie(title)
    res = self.get(URI.escape("/api/v1/movies/#{title}"))
    body = res.value || res.parsed_response
    {
        title: body.dig('data', 'attributes', 'title'),
        plot: body.dig('data', 'attributes', 'plot'),
        rating: body.dig('data', 'attributes', 'rating'),
        img_url: "#{self.base_uri}#{body.dig('data', 'attributes', 'poster')}"
    }
  end
end
