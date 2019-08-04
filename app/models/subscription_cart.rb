class SubscriptionCart
  attr_accessor :user

  def initialize user
    @user = user
  end

  def subscriptions
    @subscriptions ||= user.subscriptions_in_cart
  end

  def total_cost
    subscriptions.map(&:plan).map(&:price).map(&:to_i).sum
  end

  def item_attribute
    :subscription_ids
  end

  def item_ids
    subscriptions.map(&:id)
  end
end