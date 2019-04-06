require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  context "when user is signed in" do
    let!(:movie) { create(:movie) }
    let!(:user) { create(:user, :confirmed) }

    before do
      visit "/users/sign_in"
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Log in"
    end

    describe "send info about movie" do
      it "creates new task in background" do
        visit "/movies/#{movie.id}"
        click_link "Email me details about this movie"
        expect(page).to have_selector("div#flash_notice", text: "Email sent with movie info")
        expect(ActionMailer::DeliveryJob).to(
          have_been_enqueued.with("MovieInfoMailer", "send_info", "deliver_now", user, movie)
        )
      end
    end

    describe "export movies" do
      it "creates new task in background" do
        click_link "Export"
        expect(page).to have_selector("div#flash_notice", text: "Movies exported")
        expect(MovieExporterJob).to have_been_enqueued
      end
    end
  end
end
