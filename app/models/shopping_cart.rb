class ShoppingCart
  attr_accessor :user

  def initialize user
    @user = user
  end

  def tickets
    @tickets ||= user.tickets_in_cart
  end

  def events
    tickets.map(&:event).uniq.sort_by(&:name)
  end

  def tickets_by_performance
    tickets.group_by{|ticket| ticket.performance.id}
  end

  def performance_count
    tickets_by_performance.each_pair.each_with_object({}) do |pair, result|
      result[pair.first] = pair.last.size
    end
  end

  def performances_for(event)
    tickets.map(&:performance).select{|performance| performance.event == event}
      .uniq.sort_by(&:start_time)
  end

  def subtotal_for(performance)
    tickets_by_performance[performance.id].map{|ticket| ticket.price.to_i}.sum
  end

  def total_cost
    tickets.map{|ticket| ticket.price.to_i}.sum
  end

  def item_attribute
    :ticket_ids
  end

  def item_ids
    tickets.map(&:id)
  end
end
