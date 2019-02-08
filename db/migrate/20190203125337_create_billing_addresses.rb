class CreateBillingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_addresses do |t|
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :plz
      t.string :locality
      t.string :country
      t.timestamps
    end
  end
end
