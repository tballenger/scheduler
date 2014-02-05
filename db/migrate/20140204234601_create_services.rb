class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false, index: true
      t.text :description
      t.decimal :price, null: false
      t.integer :minutes_duration, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
