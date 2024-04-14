class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
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
    true if user.id.present? && user.id == @comment.user_id
  end

  def edit?
    update?
  end

  def destroy?
    true if user.id.present? && user.id == @comment.user_id
  end
end
