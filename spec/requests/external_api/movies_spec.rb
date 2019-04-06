require "rails_helper"

RSpec.describe "External movies API caller", type: :request do
  describe "find specific movie" do
    context "when visits correct endpoint" do
      let!(:movie) { create(:movie, title: "Godfather") }

      before do
        stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather")
          .to_return(File.open(Rails.root.join("spec", "support", "responses", "godfather_response.txt")))
      end

      it "returns valid response" do
        visit "/external_api/movies?title=#{movie.title}"
        expect(page.body).to include_json(title: "Godfather",
                                          plot: "The aging patriarch of an organized crime dynasty transfers " \
                                                "control of his clandestine empire to his reluctant son.",
                                          rating: 9.2,
                                          img_url: "https://pairguru-api.herokuapp.com/godfather.jpg")
      end
    end
  end
end
