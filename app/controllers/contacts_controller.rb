class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  before_filter :find_event_and_slot, only: [:new,:create]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    if session[:xero_auth] && $xero
      begin
        @remote_contacts = $xero.Contact.all(:order => 'Name')
      rescue
        #expired session
        session[:xero_auth] = nil
        $xero = nil
      end
    else
      @remote_contacts = []
    end
  end

  # GET /contacts
  # GET /contacts.json
  def synchronize
    if session[:xero_auth] && $xero
      Contact.synchronize($xero)
    else
      raise 'Not connection Found'
    end
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save && @time_slot.update_attribute(:contact,@contact)
        format.html { redirect_to root_path, notice: 'Appointment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :first_name, :last_name, :email_address, :phone_number, :xero_uid, :user_id)
  end

  def find_event_and_slot
    begin
      @event = Event.find(session[:event_id_selected]) if session[:event_id_selected].present?
      @time_slot = TimeSlot.find(session[:time_slot_id_selected]) if session[:time_slot_id_selected].present?
    rescue
      session[:event_id_selected] = nil
      session[:time_slot_id_selected] = nil
    end
  end

end
