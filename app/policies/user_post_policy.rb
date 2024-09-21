class UserPostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def index?
    true
  end

  def show?
    false
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    right_user?
  end

  def edit?
    update?
  end

  def destroy?
    right_user?
  end

  private

  def right_user?
    user.id.present? && user.id == @post.user_id
  end
end
