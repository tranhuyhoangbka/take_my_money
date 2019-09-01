class UnauthorizedPurchaseException < StandardError
  attr_accessor :user

  def initialize message = nil, user
    super(message)
    @user = user
  end
end
