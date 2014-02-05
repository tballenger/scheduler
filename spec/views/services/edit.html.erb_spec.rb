require 'spec_helper'

describe "services/edit" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :name => "MyString",
      :description => "MyText",
      :price => "",
      :minutes_duration => "9.99"
    ))
  end

  it "renders the edit service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", service_path(@service), "post" do
      assert_select "input#service_name[name=?]", "service[name]"
      assert_select "textarea#service_description[name=?]", "service[description]"
      assert_select "input#service_price[name=?]", "service[price]"
      assert_select "input#service_minutes_duration[name=?]", "service[minutes_duration]"
    end
  end
end
