require 'rails_helper'

include Helpers

RSpec.describe Beer, type: :model do
  let!(:style) { FactoryGirl.create :style}
  it "beer is saved with name and style" do

  	beer = Beer.create name:"Kuohuva 3", style:style

  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)
  end

  it "beer is not saved without a name" do
  	beer = Beer.create style:style

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "beer is not saved without a style" do
  	beer = Beer.create name:"Kuohuva 3"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
