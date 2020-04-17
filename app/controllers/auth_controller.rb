class AuthController < ApplicationController
  before_action :require_login, except: %i[login auto_login]
  def login
    @customer = Customer.find_by(email: params[:email])
    if @customer&.authenticate(params[:password])
      payload = { customer_id: @customer.id }
      token = encode_token(payload)
      render json: { customer: @customer, jwt: token, success: "Welcome back, #{@customer.first_name}" }
    else
      render json: { failure: "Log in failed! email or password invalid!" }
    end
  end

  def auto_login
    if session_customer
      render json: session_customer
    else
      render json: { errors: "No User Logged In" }
    end
  end

  def user_is_authed
    render json: { message: "You are authorized", status: "authorized" }
  end
end
