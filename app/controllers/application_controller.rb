class ApplicationController < ActionController::Base
  # helper_method :login!, :logged_in?, :current_customer, :authorized_customer?, :logout!

  # def login!
  #   session[:customer_id] = @customer.id
  # end

  # def logged_in?
  #   !!session[:customer_id]
  # end

  # def current_customer
  #   @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  # end

  # def authorized_customer?
  #   @customer == current_customer
  # end

  # def logout!
  #   session.clear
  # end

  skip_before_action :verify_authenticity_token
  before_action :require_login

  def encode_token(payload)
    JWT.encode(payload, "c9294246-feb4-477f-b424-5692e641b7fd")
  end

  def session_customer
    decoded_hash = decoded_token
    @customer = nil
    unless decoded_hash.empty?
      customer_id = decoded_hash[0]["customer_id"]
      @customer = Customer.find_by(id: customer_id)
    end
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    token = auth_header.split(" ")[1]
    begin
      JWT.decode(token, "c9294246-feb4-477f-b424-5692e641b7fd", true, algorithm: "HS256")
    rescue JWT::DecodeError
      []
    end
  end

  def logged_in?
    !!session_customer
  end

  def require_login
    render json: { message: "Please Login" }, status: :unauthorized unless logged_in?
  end
end
