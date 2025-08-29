class UserAbility
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all
    can :create, [User]
    can :manage, [User, Propose, Model, Report, Compliment] if user
  end
end
