require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TimeSlotsController do

  # This should return the minimal set of attributes required to create a valid
  # TimeSlot. As you add validations to TimeSlot, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "starts_at" => "2014-02-05 14:44:32" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TimeSlotsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all time_slots as @time_slots" do
      time_slot = TimeSlot.create! valid_attributes
      get :index, {}, valid_session
      assigns(:time_slots).should eq([time_slot])
    end
  end

  describe "GET show" do
    it "assigns the requested time_slot as @time_slot" do
      time_slot = TimeSlot.create! valid_attributes
      get :show, {:id => time_slot.to_param}, valid_session
      assigns(:time_slot).should eq(time_slot)
    end
  end

  describe "GET new" do
    it "assigns a new time_slot as @time_slot" do
      get :new, {}, valid_session
      assigns(:time_slot).should be_a_new(TimeSlot)
    end
  end

  describe "GET edit" do
    it "assigns the requested time_slot as @time_slot" do
      time_slot = TimeSlot.create! valid_attributes
      get :edit, {:id => time_slot.to_param}, valid_session
      assigns(:time_slot).should eq(time_slot)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TimeSlot" do
        expect {
          post :create, {:time_slot => valid_attributes}, valid_session
        }.to change(TimeSlot, :count).by(1)
      end

      it "assigns a newly created time_slot as @time_slot" do
        post :create, {:time_slot => valid_attributes}, valid_session
        assigns(:time_slot).should be_a(TimeSlot)
        assigns(:time_slot).should be_persisted
      end

      it "redirects to the created time_slot" do
        post :create, {:time_slot => valid_attributes}, valid_session
        response.should redirect_to(TimeSlot.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved time_slot as @time_slot" do
        # Trigger the behavior that occurs when invalid params are submitted
        TimeSlot.any_instance.stub(:save).and_return(false)
        post :create, {:time_slot => { "starts_at" => "invalid value" }}, valid_session
        assigns(:time_slot).should be_a_new(TimeSlot)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TimeSlot.any_instance.stub(:save).and_return(false)
        post :create, {:time_slot => { "starts_at" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested time_slot" do
        time_slot = TimeSlot.create! valid_attributes
        # Assuming there are no other time_slots in the database, this
        # specifies that the TimeSlot created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TimeSlot.any_instance.should_receive(:update).with({ "starts_at" => "2014-02-05 14:44:32" })
        put :update, {:id => time_slot.to_param, :time_slot => { "starts_at" => "2014-02-05 14:44:32" }}, valid_session
      end

      it "assigns the requested time_slot as @time_slot" do
        time_slot = TimeSlot.create! valid_attributes
        put :update, {:id => time_slot.to_param, :time_slot => valid_attributes}, valid_session
        assigns(:time_slot).should eq(time_slot)
      end

      it "redirects to the time_slot" do
        time_slot = TimeSlot.create! valid_attributes
        put :update, {:id => time_slot.to_param, :time_slot => valid_attributes}, valid_session
        response.should redirect_to(time_slot)
      end
    end

    describe "with invalid params" do
      it "assigns the time_slot as @time_slot" do
        time_slot = TimeSlot.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TimeSlot.any_instance.stub(:save).and_return(false)
        put :update, {:id => time_slot.to_param, :time_slot => { "starts_at" => "invalid value" }}, valid_session
        assigns(:time_slot).should eq(time_slot)
      end

      it "re-renders the 'edit' template" do
        time_slot = TimeSlot.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TimeSlot.any_instance.stub(:save).and_return(false)
        put :update, {:id => time_slot.to_param, :time_slot => { "starts_at" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested time_slot" do
      time_slot = TimeSlot.create! valid_attributes
      expect {
        delete :destroy, {:id => time_slot.to_param}, valid_session
      }.to change(TimeSlot, :count).by(-1)
    end

    it "redirects to the time_slots list" do
      time_slot = TimeSlot.create! valid_attributes
      delete :destroy, {:id => time_slot.to_param}, valid_session
      response.should redirect_to(time_slots_url)
    end
  end

end