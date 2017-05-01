class ProductPolicy < ApplicationPolicy

  def show?
    true
  end

  def new?
    current_user
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    edit?
  end

  def destroy?
    false
  end

end