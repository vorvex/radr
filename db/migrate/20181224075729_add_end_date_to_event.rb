class AddEndDateToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :end_date, :string
  end
end
