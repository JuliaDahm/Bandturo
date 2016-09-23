class ChargesController < ApplicationController

  def new
  end 

  def create

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      @amount = params[:amount]
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Bandturo Customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
