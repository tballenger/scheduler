require 'spec_helper'

describe "contacts/index" do
  before(:each) do
    assign(:contacts, [
      stub_model(Contact,
        :name => "Name",
        :first_name => "First Name",
        :last_name => "Last Name",
        :email_address => "Email Address",
        :phone_number => "Phone Number",
        :xero_uid => "Xero Uid",
        :user_id => 1
      ),
      stub_model(Contact,
        :name => "Name",
        :first_name => "First Name",
        :last_name => "Last Name",
        :email_address => "Email Address",
        :phone_number => "Phone Number",
        :xero_uid => "Xero Uid",
        :user_id => 1
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Xero Uid".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
