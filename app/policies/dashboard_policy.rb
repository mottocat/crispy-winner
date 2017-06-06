class DashboardPolicy < ApplicationPolicy

  def index?
    current_user && current_user.admin?
  end

end