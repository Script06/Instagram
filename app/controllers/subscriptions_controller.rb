# frozen_string_literal: true

before_action :set_subscription, only: %i[destroy]
before_action :create_subscription, only: %i[create]

class SubscriptionsController < ApplicationController
  SUBSCRIPTION_SUCCESS = "Вы успешно подписались!"
  SUBSCRIPTION_ERROR = "Не удалось подписаться"
  SUCCESS_DESTROY_SUBSCRIPTION = "Подписка успешно отменена!"
  ERROR_DESTROY_SUBSCRIPTION = "Не удалось отменить подписку"
  def create
    if @subscription.save
      redirect_back(fallback_location: root_path,
                    notice: SUBSCRIPTION_SUCCESS)
    else
      redirect_back(fallback_location: root_path,
                    notice: SUBSCRIPTION_ERROR)
    end
  end

  def destroy
    if @subscription&.destroy
      redirect_back(fallback_location: root_path,
                    notice: SUCCESS_DESTROY_SUBSCRIPTION)
    else
      redirect_back(fallback_location: root_path,
                    notice: ERROR_DESTROY_SUBSCRIPTION)
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
