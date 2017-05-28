class ProductPolicy < ApplicationPolicy

  def index?
    true
  end

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
    current_user.try(:admin?)
  end

  def update?
    edit?
  end

  def destroy?
    current_user.try(:admin?)
  end

end