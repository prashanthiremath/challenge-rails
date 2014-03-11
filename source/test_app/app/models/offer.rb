class Offer < ActiveRecord::Base
 
  validates :merchant_id, :presence => true, :uniqueness => true 
  
  def self.get_offers(options = {})
    params = {
      "website-id" => WEBSITE_ID,
      "advertiser-ids" => options["advertiser-ids"],
      "keywords" => options["keywords"],
      "category" => options["category"],
      "link-type" => options["link-type"],
      "promotion-type" => options["promotion-type"],
      "promotion-start-date" => options["promotion-start-date"],
      "promotion-end-date" => options["promotion-end-date"],
      "page-number" => options["page-number"],
      "records-per-page" => options["records-per-page"] || RECORD_PER_PAGE
    }
    uri = URI(API_URL)
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    res = http.get(uri.request_uri, {'authorization' => AUTHORIZATION})
    Rails.logger.debug "RES #{res.body}"
    offers = Hash.from_xml(res.body)
    if !offers["cj_api"].blank? and !offers["cj_api"]["links"].blank? and !offers["cj_api"]["links"]["link"].blank?
      offers = offers["cj_api"]["links"]["link"]
      offers.each do |offer|
        merchant = Merchant.find_by_id offer["advertiser_id"]
        if merchant.blank?
          merchant = Merchant.create({:name => offer["advertiser_name"], :api_merchant_id => offer["advertiser_id"]})
        end
        Offer.create({
          :merchant_id  => merchant.id,
          :title        => offer["link_name"],
          :description  => offer["description"],
          :url          => offer["destination"],
          :expires_at   => offer["promotion_end_date"],
          :category     => offer["category"],
          :api_link_id  => offer["link_id"],
          :link_type    => offer["link_type"]
        }) if !offer["link_name"].blank? and !offer["destination"].blank?
      end
    end
  end
end
