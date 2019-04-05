require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  it { is_expected.to allow_value("content").for(:content) }
  it { is_expected.to_not allow_value(nil).for(:content) }
  it { is_expected.to_not allow_value("").for(:content) }

  it { is_expected.to allow_value(user).for(:user) }
  it { is_expected.to_not allow_value(nil).for(:user) }

  it { is_expected.to allow_value(movie).for(:movie) }
  it { is_expected.to_not allow_value(nil).for(:movie) }

  context "when there exists comment created by user under movie" do
    before { create(:comment, user: user, movie: movie) }
    subject { described_class.new(content: "content", user: user, movie: movie) }
    it { is_expected.to_not be_valid }
  end

  context "when there is no existed comment created by user under movie" do
    subject { described_class.new(content: "content", user: user, movie: movie) }
    it { is_expected.to be_valid }
  end
end
