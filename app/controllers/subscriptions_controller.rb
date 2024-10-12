# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def create
    if current_user.follow(@user)
      redirect_back(fallback_location: root_path,
                    notice: t('.subscription_success'))
    else
      redirect_back(fallback_location: root_path,
                    notice: t('.subscription_error'))
    end
  end

  def destroy
    if current_user.unfollow(@user)
      redirect_back(fallback_location: root_path,
                    notice: t('.success_destroy_subscription'))
    else
      redirect_back(fallback_location: root_path,
                    notice: t('.error_destroy_subscription'))
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
