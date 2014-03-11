require 'spec_helper'

describe Offer do
  
  before(:all) do
   FakeWeb.register_uri(:get,API_URL + "?website-id=5742006&advertiser-ids&keywords&category&link-type&promotion-type&promotion-start-date&promotion-end-date&page-number&records-per-page=20", :body => File.read($MOCK_SERVICE_RETURNS_PATH + "/result.mock"))
   Offer.delete_all
  end 

  it "crawl the API and create offers in the database" do
     Offer.get_offers
     Offer.count.should be > 0
  end

   it "Should be able to crawl the API multiple times and not create duplicate offers." do
     Offer.get_offers
     count = Offer.count
     Offer.get_offers
     expect(Offer.count).to eq(count)
  end
  
end