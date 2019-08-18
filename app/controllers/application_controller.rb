class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_admin_user!
    raise Pundit::NotAuthorizedError unless current_user&.admin?
  end

  private
  def user_not_authorized
    sign_out(User)
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end
end
