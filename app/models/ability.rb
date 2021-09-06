class Ability
  include CanCan::Ability
  def initialize user
    case user.role.to_sym
    when :admin
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
    when :staff
      can :access, :rails_admin
      can :read, :dashboard
      can :read, User
      can :manage, Booking
      can :manage, Payment
      can :manage, Room
      can :manage, RoomType
      cannot %i(destroy create new), Payment
    end
  end
end
