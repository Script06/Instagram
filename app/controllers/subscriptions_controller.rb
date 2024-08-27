class SubscriptionsController < ApplicationController
  def create
    Subscription.create(follower_id: current_user.id, following_id: params[:id])

    redirect_back(fallback_location: root_path)
  end

  def destroy
    Subscription.find_by(follower_id: current_user.id, following_id: params[:id])&.destroy

    redirect_back(fallback_location: root_path)
  end
end
