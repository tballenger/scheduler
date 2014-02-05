require 'spec_helper'

describe "time_slots/new" do
  before(:each) do
    assign(:time_slot, stub_model(TimeSlot,
      :event_id => 1,
      :contact_id => 1
    ).as_new_record)
  end

  it "renders new time_slot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_slots_path, "post" do
      assert_select "input#time_slot_event_id[name=?]", "time_slot[event_id]"
      assert_select "input#time_slot_contact_id[name=?]", "time_slot[contact_id]"
    end
  end
end
