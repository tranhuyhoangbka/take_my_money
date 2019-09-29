class ShippingDetailsController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    workflow = AddsShippingToCart.new(user: current_user, address: address_params, method: params[:shipping_method])
    workflow.run
    if workflow.success?
      flash[:success] = "Add shipping detail success"
      redirect_to shopping_cart_path
    else
      render :new
    end
  end

  private
  def address_params
    params.require(:address).permit(:address_1, :address_2, :city, :state, :zip)
  end
end