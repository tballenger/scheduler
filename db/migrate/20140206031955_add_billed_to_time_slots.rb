class AddBilledToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :billed, :boolean, default:false
  end
end
