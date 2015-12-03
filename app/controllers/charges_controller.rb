class ChargesController < ApplicationController

  def create

    #Creates a Stripe Customer object, for associating with the charge.
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )


  # Payment being made
  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: 15_00,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )

  flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
  redirect_to root_path

  # Stripe will send back CardErrors, with friendly messages when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: 15_00
    }
  end

end
