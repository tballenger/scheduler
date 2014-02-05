require 'spec_helper'

describe "time_slots/show" do
  before(:each) do
    @time_slot = assign(:time_slot, stub_model(TimeSlot,
      :event_id => 1,
      :contact_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
