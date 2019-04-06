require "rails_helper"

RSpec.describe MovieExporterJob, type: :job do
  describe "#perform_later" do
    it "enqueue job" do
      described_class.perform_later
      expect(described_class).to have_been_enqueued
    end
  end
end
