class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Only return teams that belong to the user
      scope.where(user: user)
    end
  end

  def show?
    # Only the owner can view the team
    record.user == user
  end

  def create?
    # Any authenticated user can create a team
    true
  end
end
