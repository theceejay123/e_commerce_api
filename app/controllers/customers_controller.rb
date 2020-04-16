class CustomersController < ApplicationController
  skip_before_action :require_login, only: %i[create index]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.includes(:province, :order_details).all
    if @customers
      render json: {
        customers: @customers
      }
    else
      render json: {
        status: 500,
        errors: ["no users found"]
      }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show; end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit; end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer.valid?
      @customer.save
      payload = { customer_id: @customer.id }
      token = encode_token(payload)
      puts token
      render json: { customer: @customer, jwt: token }
    else
      render json: { errors: @customer.errors.full_messages }, status: :not_acceptable
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Format to json
  def set_format
    request.format = :json
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address, :phone_number, :province_id, :password_digest)
  end
end
