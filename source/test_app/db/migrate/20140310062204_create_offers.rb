class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :merchant_id
      t.string :category
      t.string :description
      t.string :url
      t.string :api_link_id
      t.string :title
      t.string :link_type
      t.datetime :expires_at
      t.timestamps
    end
  end
end
