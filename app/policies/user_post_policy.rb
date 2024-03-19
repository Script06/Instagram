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
    true if user.id.present? && user.id == @post.user_id
  end

  def edit?
    update?
  end

  def destroy?
    true if user.id.present? && user.id == @post.user_id
  end
end
