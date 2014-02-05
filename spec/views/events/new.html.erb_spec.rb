require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :name => "MyString",
      :service_id => 1,
      :day => "MyString",
      :from => "MyString",
      :to => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", events_path, "post" do
      assert_select "input#event_name[name=?]", "event[name]"
      assert_select "input#event_service_id[name=?]", "event[service_id]"
      assert_select "input#event_day[name=?]", "event[day]"
      assert_select "input#event_from[name=?]", "event[from]"
      assert_select "input#event_to[name=?]", "event[to]"
      assert_select "input#event_user_id[name=?]", "event[user_id]"
    end
  end
end
