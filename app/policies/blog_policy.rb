class BlogPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.author?
        scope.where(author_id: @user.id)
      else
        scope.all
      end
    end
  end

  def create?
    user.author?
  end

  def update?
    user.author?
  end

  def destroy?
    user.author?
  end
end
