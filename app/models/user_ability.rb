class UserAbility
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    if user
    if user.admin? # Admin user
      can :manage, :all
    else # Non-admin user
      cannot :manage, :all
      can :create, [User]
      can :manage, [User, Propose, Model, Report, Compliment] if user
    end
    end

  end
end
