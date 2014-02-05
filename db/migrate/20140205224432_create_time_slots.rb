class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.integer :event_id, null: false, index: true
      t.integer :contact_id

      t.timestamps
    end
  end
end
