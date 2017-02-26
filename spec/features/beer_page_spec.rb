require 'rails_helper'

include Helpers

describe "Beers page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" } 
  let!(:user) { FactoryGirl.create :user }
  let!(:style) {FactoryGirl.create :style }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end
  
  it "a new beer is added when valid name is given" do    
  	visit new_beer_path
  	fill_in('beer_name', with:"Iso 3")
  	select('Lager', from:'beer[style_id]')
  	select('Koff', from:'beer[brewery_id]')

  	expect{
  		click_button "Create Beer"
  	}.to change{Beer.count}.from(0).to(1)
  end

  it "a new beer is not added when no name is given" do
  	visit new_beer_path
  	fill_in('beer_name', with:"")
  	select('Lager', from:'beer[style_id]')
  	select('Koff', from:'beer[brewery_id]')
  	click_button "Create Beer"
  	
  	expect(Beer.count).to eq(0)
  	expect(page).to have_content "Name can't be blank"
  end
end