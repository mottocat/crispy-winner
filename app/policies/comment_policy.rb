class CommentPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    current_user && !current_user.has_comment_on?(record.product)
  end

  def edit?
    update?
  end

  def update?
    current_user && current_user.comment_owner?(record)
  end

  def destroy?
    update?
  end


end