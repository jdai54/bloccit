require 'rails_helper'

RSpec.describe Sponsoredpost, type: :model do
  let(:title) { RandomData.random_sentence}
  let(:body) { RandomData.random_paragraph }
  let(:price) { RandomData.random_number }
  let(:topic) { Topic.create!(name: name, description: description) }
  let(:sponsoredpost) { topic.sponsoredposts.create!(title: title, body: body, price: price) }

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has a title, body, and price attribute" do
      expect(sponsoredpost).to have_attributes(title: title, body: body, price: price)
    end
  end
end
