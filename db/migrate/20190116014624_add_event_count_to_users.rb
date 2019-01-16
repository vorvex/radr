class AddEventCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :event_count, :integer, default: 0
  end
end
