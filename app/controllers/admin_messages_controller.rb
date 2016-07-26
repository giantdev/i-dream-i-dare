class AdminMessagesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:landing_page]
  before_action :set_admin_message, only: [:show, :edit, :update, :destroy]

  # /////////////////////////////

  before_filter :check_access, :only => :show

  # /////////////////////////////


  # GET /
  def landing_page
    time = Time.new
    days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    @day_of_week = days[time.wday] 
    @month = time.month
    @day_number = time.day
    @year = time.year
    @admin_message = AdminMessage.new
  end

  # GET /admin_messages
  def index
    @admin_messages = AdminMessage.all
  end

  # GET /admin_messages/1
  def show
  end

  # GET /admin_messages/new
  def new
    @admin_message = AdminMessage.new
  end

  # GET /admin_messages/1/edit
  def edit
  end

  # POST /admin_messages
  def create
    @admin_message = AdminMessage.new(admin_message_params)

    if @admin_message.save
      redirect_to @admin_message, notice: 'Admin message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin_messages/1
  def update
    if @admin_message.update(admin_message_params)
      redirect_to @admin_message, notice: 'Admin message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin_messages/1
  def destroy
    @admin_message.destroy
    redirect_to admin_messages_url, notice: 'Admin message was successfully destroyed.'
  end

# /////////////This is my before filter that prevents unauth access to view admin messages.////////////////////

  protected

  def check_access
    redirect_to 'landing_page' unless current_user.is_an_admin?
  end

# ////////////////////////////////



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_message
      @admin_message = AdminMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_message_params
      params.require(:admin_message).permit(:from_name, :from_email, :content)
    end
end
