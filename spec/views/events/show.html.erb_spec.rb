require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "Name",
      :service_id => 1,
      :day => "Day",
      :from => "From",
      :to => "To",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Day/)
    rendered.should match(/From/)
    rendered.should match(/To/)
    rendered.should match(/2/)
  end
end
