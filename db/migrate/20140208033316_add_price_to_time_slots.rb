class AddPriceToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :price, :decimal
  end
end
