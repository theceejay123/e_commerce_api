class CheckoutController < ApplicationController
  def create
    cart = JSON.parse(params[:cart])
    customer_id = JSON.parse(params[:id])
    # render json: { cart: JSON.parse(cart) }
    ids = []
    quantities = []
    cart.each do |each_item|
      ids.push(each_item["id"])
      quantities.push(each_item["quantity"])
    end

    products = Product.find(ids)
    customer = Customer.find(customer_id)

    redirect_to "http://localhost:31337/cart" if products.nil? || customer.nil?

    products_array = []
    taxes_array = []
    total_amount = 0

    products.each_with_index do |item, index|
      products_array.push(
        amount:      (item.price * 100).to_i,
        name:        item.name,
        description: "#{item.description} by #{item.photographer.full_name}",
        quantity:    quantities[index],
        currency:    "cad"
      )
    end

    products_array.each do |item|
      total_amount += item[:amount] * item[:quantity]
    end

    customer.province.taxes.each do |item|
      taxes_array.push(
        amount:      total_amount * item.tax.to_i / 100,
        name:        item.name,
        description: item.name == "GST" ? "Goods & Services Tax" : item.name == "HST" ? "Harmonized Sales Tax" : "Provincial Sales Tax",
        currency:    "cad",
        quantity:    1
      )
    end

    encoded_cart = ERB::Util.url_encode(cart.to_json)
    encoded_id = ERB::Util.url_encode(customer_id.to_json)

    @session = Stripe::Checkout::Session.create(
      customer_email:       customer.email,
      payment_method_types: ["card"],
      line_items:           [(products_array << taxes_array).flatten!],
      success_url:          "http://localhost:31337/transaction_successful?session_id={CHECKOUT_SESSION_ID}&cart=#{encoded_cart}&id=#{encoded_id}",
      cancel_url:           "http://localhost:31337/transaction_canceled"
    )

    render json: { session: @session }
  end

  def success
    cart = JSON.parse(params[:cart])
    customer_id = JSON.parse(params[:id])

    # puts cart
    # cart.each do |each_item|
    #   puts each_item
    # end
    # Retrieve current Stripe session
    session = Stripe::Checkout::Session.retrieve(params[:sessionId].to_s)

    # Get the payment intent of the session
    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)

    if payment_intent.status != "succeeded"
      redirect_to "http://localhost:31337/transaction_canceled"
    end

    # Variables to use
    total_amount = 0
    total_tax_amount = 0

    # Find customer and products by id
    ids = []
    quantities = []
    cart.each do |each_item|
      ids.push(each_item["id"])
      quantities.push(each_item["quantity"])
    end

    products = Product.find(ids)
    customer = Customer.find(customer_id)

    products.each do |item|
      total_amount += item.price
    end

    customer.province.taxes.each do |item|
      total_tax_amount += total_amount * item.tax.to_i / 100
    end

    order = customer.order_details.create(
      reference_number: payment_intent.charges.data[0].created,
      historical_tax:   total_tax_amount,
      total:            total_amount
    )

    products.each_with_index do |item, index|
      item.details.create(
        price:           item.price,
        quantity:        quantities[index],
        order_detail_id: order.id
      )
    end

    render json: { order_details: order.details, order: order, products: order.products }
  end
end
