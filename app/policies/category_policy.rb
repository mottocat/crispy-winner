class CategoryPolicy < ApplicationPolicy

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    current_user && current_user.admin?
  end

  def edit?
    update?
  end

  def update?
    current_user && current_user.admin?
  end

  def destroy?
    update?
  end


end