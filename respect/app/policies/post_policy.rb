class PostPolicy < ApplicationPolicy

  def create?
    true
  end
  
  def show?
    true  
  end

  def update?
    record.user_id == user_id
  end

  def destroy?
    record.user_id == user_id
  end
end