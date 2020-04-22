class CheckoutController < ApplicationController
  def create
    products = Product.find(params[:cart])
    customer = Customer.find(params[:id])

    redirect_to "http://localhost:31337/cart" if products.nil? || customer.nil?

    products_array, taxes_array = []
    total_amount = 0

    products.each do |item|
      products_array.push(
        amount:      (item.price * 100).to_i,
        name:        item.name,
        description: "#{item.description} by #{item.photographer.name}",
        quantity:    1,
        currency:    "cad"
      )
    end

    products_array.each do |item|
      total_amount += item[:amount]
    end

    customer.province.taxes.each do |item|
      taxes_array.push(
        amount:      total_amount * item.tax.to_i / 100,
        name:        item.name,
        description: item.name == "GST" ? "Goods & Services Tax" : "Provincial Sales Tax",
        currency:    "cad",
        quantity:    1
      )
    end

    @session = Stripe::Checkout::Session.create(
      customer_email:       customer.email,
      payment_method_types: ["card"],
      line_items:           [(products_array << taxes_array).flatten!],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )
  end

  def cancel; end

  def success; end
end
