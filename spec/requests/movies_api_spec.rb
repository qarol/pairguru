require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies API list" do
    it "displays empty json" do
      visit "/api/movies"
      expect(page.body).to include_json(data: be_empty)
    end

    it "displays empty json" do
      visit "/api/movies?include=genre"
      expect(page.body).to include_json(data: be_empty,
                                        included: be_empty)
    end

    context "when there are some movies in DB" do
      let!(:genre) { create(:genre) }
      let!(:movie) { create(:movie, genre: genre) }

      it "displays movie data" do
        visit "/api/movies"
        expect(page.body).to include_json(data: [{
                                            id: movie.id.to_s,
                                            type: "movie",
                                            attributes: {
                                              id: movie.id,
                                              title: movie.title
                                            },
                                            relationships: {
                                              genre: {
                                                data: {
                                                  id: movie.genre_id.to_s,
                                                  type: "genre"
                                                }
                                              }
                                            }
                                          }])
      end

      it "displays movie data with genre" do
        visit "/api/movies?include=genre"
        expect(page.body).to include_json(data: [{
                                            id: movie.id.to_s,
                                            type: "movie",
                                            attributes: {
                                              id: movie.id,
                                              title: movie.title
                                            },
                                            relationships: {
                                              genre: {
                                                data: {
                                                  id: movie.genre_id.to_s,
                                                  type: "genre"
                                                }
                                              }
                                            }
                                          }],
                                          included: [
                                            {
                                              id: genre.id.to_s,
                                              type: "genre",
                                              attributes: {
                                                id: genre.id,
                                                name: genre.name,
                                                movies_count: 1
                                              }
                                            }
                                          ])
      end
    end
  end
end
