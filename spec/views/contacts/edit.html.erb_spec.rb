require 'spec_helper'

describe "contacts/edit" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :name => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :email_address => "MyString",
      :phone_number => "MyString",
      :xero_uid => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do
      assert_select "input#contact_name[name=?]", "contact[name]"
      assert_select "input#contact_first_name[name=?]", "contact[first_name]"
      assert_select "input#contact_last_name[name=?]", "contact[last_name]"
      assert_select "input#contact_email_address[name=?]", "contact[email_address]"
      assert_select "input#contact_phone_number[name=?]", "contact[phone_number]"
      assert_select "input#contact_xero_uid[name=?]", "contact[xero_uid]"
      assert_select "input#contact_user_id[name=?]", "contact[user_id]"
    end
  end
end
