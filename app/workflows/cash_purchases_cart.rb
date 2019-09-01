class CashPurchasesCart < PreparesCart
  def run
    Payment.transaction do
      pre_purchase_valid?
      update_tickets
      create_payment
      on_success
    end
  rescue
    on_failure
  end

  def redirect_on_success_url
    nil
  end

  private
  def update_tickets
    tickets.each{|ticket| ticket.update! user: user}.each(&:purchased!)
  end

  def create_payment
    @payment = Payment.create! payment_attributes
    @payment.update tickets: user.tickets
  end

  def on_success
    @success = true
  end

  def pre_purchase_valid?
    # raise UnauthorizedPurchaseException.new(user: user) unless user.admin?
    true
  end

  def on_failure
    # unpurchase_tickets
    @success = false
  end
end