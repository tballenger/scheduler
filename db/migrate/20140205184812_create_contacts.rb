class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email_address
      t.string :phone_number
      t.string :xero_uid, index: true
      t.integer :user_id

      t.timestamps
    end
  end
end
