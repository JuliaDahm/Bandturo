class ChargesController < ApplicationController

  def new
  end 

  def create

    @amount = case params[:plan_chosen]
      when 0 then 4900 
      when 1 then 9900
      when 2 then 19900
      else
        raise 'Plan not supported'
      end

    @description = case params[:plan_chosen]
      when 0 then ''
      when 1 then ''
      when 2 then 'Cul-de-sac'
      else 
        raise 'plan not supported'
      end 

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @description,
      :currency    => 'usd'
    )

  if charge.save
    redirect_to thanks_index_path
  else 
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
