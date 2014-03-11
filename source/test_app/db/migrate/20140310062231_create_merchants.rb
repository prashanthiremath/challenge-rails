class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :api_merchant_id
      t.timestamps
    end
  end
end
