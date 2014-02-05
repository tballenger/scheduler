require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "MyString",
      :service_id => 1,
      :day => "MyString",
      :from => "MyString",
      :to => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select "input#event_name[name=?]", "event[name]"
      assert_select "input#event_service_id[name=?]", "event[service_id]"
      assert_select "input#event_day[name=?]", "event[day]"
      assert_select "input#event_from[name=?]", "event[from]"
      assert_select "input#event_to[name=?]", "event[to]"
      assert_select "input#event_user_id[name=?]", "event[user_id]"
    end
  end
end
