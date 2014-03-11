class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def crawl
    Offer.get_offers
    redirect_to "/offers"
  end
end
