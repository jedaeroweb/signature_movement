class AdminAbility
    include CanCan::Ability
    def initialize(user)
        user ||= User.new # guest user (not logged in)
        if user.admin? # Admin user
            can :manage, :all
        else # Non-admin user
            cannot :manage, :all
        end
    end
end
