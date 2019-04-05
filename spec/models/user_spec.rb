require "rails_helper"

describe User do
  it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }

  describe ".top_commenters" do
    context "when there is no comments" do
      it { expect(described_class.top_commenters).to be_empty }
    end

    context "when there are comments but created more than 7 days ago" do
      before do
        create_list(:comment, 10, created_at: Faker::Time.between(14.days.ago, 8.days.ago, :all))
      end
      it { expect(described_class.top_commenters).to be_empty }
    end

    context "when there are comments created less than 7 days ago" do
      let!(:user_1) { create(:user) }
      let!(:user_2) { create(:user) }
      let!(:user_3) { create(:user) }
      before do
        create_list(:comment, 10, user: user_2, created_at: Faker::Time.backward(7))
        create_list(:comment, 11, user: user_3, created_at: Faker::Time.backward(7))
      end

      it "returns correct list of data" do
        expect(described_class.top_commenters).to(
          match_array([
                        [[user_3.id, user_3.name, user_3.email], 11],
                        [[user_2.id, user_2.name, user_2.email], 10]
                      ])
        )
      end
    end

    context "when there are a lot of comments in the system" do
      before { create_list(:comment, 15, created_at: Faker::Time.backward(7)) }
      it { expect(described_class.top_commenters.size).to eq(10) }
    end
  end
end
