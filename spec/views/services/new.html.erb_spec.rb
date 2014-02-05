require 'spec_helper'

describe "services/new" do
  before(:each) do
    assign(:service, stub_model(Service,
      :name => "MyString",
      :description => "MyText",
      :price => "",
      :minutes_duration => "9.99"
    ).as_new_record)
  end

  it "renders new service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", services_path, "post" do
      assert_select "input#service_name[name=?]", "service[name]"
      assert_select "textarea#service_description[name=?]", "service[description]"
      assert_select "input#service_price[name=?]", "service[price]"
      assert_select "input#service_minutes_duration[name=?]", "service[minutes_duration]"
    end
  end
end
