class UsersController < ApplicationController
  before_action :load_user

  def show
    @subscriptions = (@user || current_user).subscriptions
  end

  def edit
  end

  def update
    @user.update user_params
    authorize(@user)
    render :show
  end

  def load_user
    @user = User.find_by_id(params[:id])
    authorize(@user)
  end

  def user_params
    params.require(:user).permit(:name)
  end
end