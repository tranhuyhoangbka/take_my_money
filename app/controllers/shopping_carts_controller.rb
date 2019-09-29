class ShoppingCartsController < ApplicationController
  def show
    @cart = ShoppingCart.for(user: current_user)
  end

  def update
    @shopping_cart = ShoppingCart.for(user: current_user)
    performance = Performance.find(params[:performance_id])
    workflow = AddsToCart.new(
      user: current_user, performance: performance,
      count: params[:ticket_count]
    )
    workflow.run
    if workflow.success
      redirect_to shopping_cart_path(id: @shopping_cart.id)
    else
      redirect_to performance.event
    end
  end
end
