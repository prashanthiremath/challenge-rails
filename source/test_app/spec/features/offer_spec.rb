require 'spec_helper'

describe "home page" do
  
  before do
  	FakeWeb.register_uri(:get,API_URL + "?website-id=5742006&advertiser-ids&keywords&category&link-type&promotion-type&promotion-start-date&promotion-end-date&page-number&records-per-page=20", :body => File.read($MOCK_SERVICE_RETURNS_PATH + "/result.mock"))
    Offer.create({ :merchant_id  => 12, :title => "GiftTree - Flowers", :description  => "Flowers", :url => "http://test.com", :expires_at   => Date.today, :category => "test"})
  end
  
  it "Should crawl for and create offers when clicking on the button and then display them. Reloading the page should still show the offers" do
    visit "/offers"
    click_link("Crawl!")
    page.should have_content "Flowers"
  end
end