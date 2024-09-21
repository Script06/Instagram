# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[destroy]
  before_action :create_subscription, only: %i[create]

  def create
    if @subscription.save
      redirect_back(fallback_location: root_path,
                    notice: t('.subscription_success'))
    else
      redirect_back(fallback_location: root_path,
                    notice: t('.subscription_error'))
    end
  end

  def destroy
    if @subscription&.destroy
      redirect_back(fallback_location: root_path,
                    notice: t('.success_destroy_subscription'))
    else
      redirect_back(fallback_location: root_path,
                    notice: t('.error_destroy_subscription'))
    end
  end

  private

  def create_subscription
    @subscription = Subscription.new(
      follower_id: current_user.id,
      following_id: params[:id]
    )
  end

  def set_subscription
    @subscription = Subscription.find_by(
      follower_id: current_user.id,
      following_id: params[:id]
    )
  end
end
