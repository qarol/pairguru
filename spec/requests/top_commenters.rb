require "rails_helper"

describe "Top Commenters", type: :request do
  describe "top commenters list" do
    it "displays right title and subtitle" do
      visit "/top_commenters"
      expect(page).to have_selector("h1", text: "Top Commenters")
      expect(page).to have_content("No one has created comment last 7 days.")
    end

    context "when there are some some comments in DB" do
      let!(:user_1) { create(:user) }
      let!(:user_2) { create(:user) }
      let!(:user_3) { create(:user) }
      before do
        create_list(:comment, 10, user: user_2, created_at: Faker::Time.backward(7))
        create_list(:comment, 11, user: user_3, created_at: Faker::Time.backward(7))
      end

      it "displays users with comment's count" do
        visit "/top_commenters"
        expect(page).to have_selector("h1", text: "Top Commenters")
        within("tr.row-1") do
          expect(page).to have_selector("td.col-nr", text: "1")
          expect(page).to have_selector("td.col-name", text: "#{user_3.name} (#{user_3.email})")
          expect(page).to have_selector("td.col-count", text: 11)
        end
        within("tr.row-2") do
          expect(page).to have_selector("td.col-nr", text: "2")
          expect(page).to have_selector("td.col-name", text: "#{user_2.name} (#{user_2.email})")
          expect(page).to have_selector("td.col-count", text: 10)
        end
        expect(page).to_not have_selector("td.col-name", text: "#{user_1.name} (#{user_1.email})")
      end
    end
  end
end
