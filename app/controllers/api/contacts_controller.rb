class Api::ContactsController < ApplicationController
  USER_NAME, PASSWORD = "admin", "password"

  before_action :set_contact, only: [:show, :update, :destroy]


  # GET /contacts
  def index
    @contacts = Contact.all

    paginate json: @contacts, per_page: 10
  end

  # GET /contacts/1
  def show
    paginate json: @contact, per_page: 10
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created #, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  # Search 

  def search_by_name
      @contact = Contact.find(params[:firstName])
      render json: @contact, status:200 #, per_page:10

  end
  def search_by_email
    @contact = Contact.find(params[:email])
    render json: @contact #, per_page:2
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:firstName, :lastName, :email)
    end

    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
end
