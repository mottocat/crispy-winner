class ApprovalImagePolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    current_user
  end

  def update?
    current_user
  end

  def permitted_attributes
    attrs = [:image]
    attrs << :status if record.persisted?
    attrs
  end

end