require 'spec_helper'

describe "time_slots/index" do
  before(:each) do
    assign(:time_slots, [
      stub_model(TimeSlot,
        :event_id => 1,
        :contact_id => 2
      ),
      stub_model(TimeSlot,
        :event_id => 1,
        :contact_id => 2
      )
    ])
  end

  it "renders a list of time_slots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
