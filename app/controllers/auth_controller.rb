class AuthController < ApplicationController
  skip_before_action :require_login, only: %i[login auto_login]
  def login
    @customer = Customer.find_by(email: params[:email])
    if @customer&.authenticate(params[:password])
      payload = { customer_id: customer.id }
      token = encode_token(payload)
      format.json { render json: { user: @customer, jwt: token, success: "Welcome back, #{Customer.first_name}" } }
    else
      format.json { render json: { failure: "Log in failed! email or password invalid!" } }
    end
  end

  def auto_login
    if session_customer
      format.json { render json: session_customer }
    else
      format.json { render json: { errors: "No User Logged In" } }
    end
  end

  def user_is_authed
    format.json { render json: { message: "You are authorized", status: "authorized" } }
  end
end
