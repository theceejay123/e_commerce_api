require "stripe"

class ChargesController < ApplicationController
  def create
    Stripe.api = "sk_test_tX0dTZRnj1FGToKpWSWow72v00cMmMDAib"

    # begin
    # customer = Stri
    # rescue StandardError
    #   asdasd
    # end
  end
end
