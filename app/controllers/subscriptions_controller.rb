class SubscriptionsController < ApplicationController
  before_action :load_subscription, only: %i(edit update)

  def edit
  end

  def update
    workflow= ChangesStripeSubscriptionPlan.new(subscription_id: params[:id], user: current_user, new_plan_id: params[:subscription][:plan_id])    
    workflow.run    
    if workflow.success
      flash[:info] = "Change subscription plan is successfully!"
    else
      flash[:error] = "Change subscription plan is failed!"
    end
    redirect_to edit_user_registration_path
  end

  def destroy
    workflow = CancelsStripeSubscription.new(subscription_id: params[:id], user: current_user)
    workflow.run    
    if workflow.success
      flash[:info] = "Cancel subscription is successfully!"
    else
      flash[:error] = "Cancel subscription is failed!"
    end
    redirect_to edit_user_registration_path
  end

  private
  def load_subscription
    @subscription = Subscription.find_by id: params[:id]
  end
end