require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:public) { true }
  let(:topic) { create(:topic) }

  it { is_expected.to have_many(:posts) }
  # #1 confirm that topic responds to the appropriate attributes
  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description)
    end
    # #2 confirm that the public attribute is set to true by default
    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end
end
