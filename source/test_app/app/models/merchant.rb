class Merchant < ActiveRecord::Base 
  validates :api_merchant_id, :presence => true, :uniqueness => true
end
