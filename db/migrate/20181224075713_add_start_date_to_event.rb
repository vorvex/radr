class AddStartDateToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start_date, :string
  end
end
