class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.subscriber?
  end

  def approve?
    user.author?
  end

  def comments_need_approval?
    user.author?
  end

  def destroy?
    user.author?
  end
end
