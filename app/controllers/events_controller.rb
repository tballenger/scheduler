class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    if session[:service_id_selected].present?
      #Events filtered by Service
      @events = Event.scoped.where(:service_id => session[:service_id_selected]).where(:user_id => @business.id)
      @events = @events.after(params['start']).where(:service_id => session[:service_id_selected]) if (params['start'])
      @events = @events.before(params['end']).where(:service_id => session[:service_id_selected]) if (params['end'])
    else
      @events = Event.where(:user_id => @business.id)
      @events = @events.after(params['start']).where(:user_id => @business.id) if (params['start'])
      @events = @events.before(params['end']).where(:user_id => @business.id) if (params['end'])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events.to_json(:event_id_selected => session[:event_id_selected]) }
    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html do
        session[:event_id_selected] = @event.id
        session[:time_slot_id_selected] = nil
        redirect_to calendar_path
      end
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json(:event_id_selected => session[:event_id_selected]) }
    end
  end

# GET /events/new
  def new
    @event = Event.new
  end

# GET /events/1/edit
  def edit
  end

# POST /events
# POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to calendar_path, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /events/1
# PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to calendar_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
        format.js { head :ok}
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

# DELETE /events/1
# DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_event
    #filer per user for security
    @event = Event.find(params[:id])
  end

  def check_authorization
    raise 'Unauthorized' if @event.user != current_user
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :starts_at, :ends_at, :all_day, :description, :service_id)
  end
end
