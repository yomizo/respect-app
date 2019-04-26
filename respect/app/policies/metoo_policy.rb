class MetooPolicy < ApplicationPolicy

  def create?
    true
  end

  def destroy?
    record.user_id == user_id
  end
end