class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false, index: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.boolean :all_day
      t.text :description

      t.timestamps
    end
  end
end
