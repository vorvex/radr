class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.integer  :user_id
      t.string   :name
      t.string   :type
      t.string   :formatted_address
      t.string   :route
      t.string   :street_number
      t.string   :postal_code
      t.string   :locality
      t.string   :place_id
      t.string   :lat
      t.string   :lng
      t.timestamps
    end
  end
end
