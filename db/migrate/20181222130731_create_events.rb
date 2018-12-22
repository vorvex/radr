class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string   :name
      t.string   :description
      t.integer  :user_id
      t.integer  :place_id
      t.datetime :start_time
      t.datetime :end_time
      t.boolean  :offer
      t.float    :price
      t.string   :ticket_url
      t.string   :ticket_status
      t.string   :pathname, default: "/"

      t.timestamps
    end
  end
end
