class AddConfirmationTokenToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :token, :string
  end
end
