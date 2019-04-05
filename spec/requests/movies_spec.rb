require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    context "when there are some movies" do
      let!(:movie) { create(:movie) }
      it "displays movie title, content & genre" do
        visit "/movies"
        within("table") { expect(page).to have_selector("h4", text: movie.title) }
      end

      it "displays content" do
        visit "/movies"
        within("table") { expect(page).to have_selector("p", text: movie.description) }
      end

      it "displays genre" do
        visit "/movies"
        within("table") { expect(page).to have_selector("a", text: movie.genre_name) }
      end
    end
  end

  describe "movie details" do
    let!(:movie) { create(:movie) }
    let!(:user) { create(:user, :confirmed) }

    it "displays movie title" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("h1", text: movie.title)
    end

    it "displays movie content" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("div.jumbotron", text: movie.description)
    end

    it "displays comment header" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("h2", text: "Comments")
    end

    context "when user is signed in" do
      before do
        visit "/users/sign_in"
        fill_in "Email", with: user.email
        fill_in "Password", with: "password"
        click_button "Log in"
      end

      it "displays form to create comment" do
        visit "/movies/#{movie.id}"
        expect(page).to have_button("Create Comment")
      end

      it "can create comment" do
        visit "/movies/#{movie.id}"
        fill_in "Comment", with: "Some text"
        click_button "Create Comment"
        expect(page).to have_selector("div#flash_notice", text: "Comment successfully created")
        expect(page).to have_selector("h4", text: user.email)
        expect(page).to have_selector("div.content", text: "Some text")
      end

      context "when there exists comment created by user" do
        let!(:comment) { create(:comment, user: user, movie: movie) }

        it "can remove existed comment" do
          visit "/movies/#{movie.id}"
          expect(page).to have_selector("h4", text: user.email)
          expect(page).to have_selector("div.content", text: comment.content)
          click_link "[remove]"
          expect(page).to_not have_selector("h4", text: user.email)
          expect(page).to_not have_selector("div.content", text: comment.content)
        end

        it "can't create new comment if there exists already comment created by user" do
          visit "/movies/#{movie.id}"
          fill_in "Comment", with: "Some content"
          click_button "Create Comment"
          expect(page).to have_selector("div#flash_alert", text: "We couldn't create comment. User have already commented this movie")
        end
      end
    end

    context "when user is not signed in" do
      it "not displays form to create comment" do
        visit "/movies/#{movie.id}"
        expect(page).to_not have_button("Create Comment")
      end
    end
  end
end
