class AddBusinessInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business_name, :string
    add_column :users, :business_description, :string
    add_column :users, :business_address, :string
    add_column :users, :business_phone, :string
    add_column :users, :business_email, :string
  end
end
