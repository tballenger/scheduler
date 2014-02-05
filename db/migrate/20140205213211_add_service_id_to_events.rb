class AddServiceIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :service_id, :integer, index: true
  end
end
