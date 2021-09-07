class Ability
  include CanCan::Ability
  def initialize user
    user ||= User.new
    case user.role.to_sym
    when :admin
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
      cannot %i(destroy create new), Payment
    when :staff
      can :access, :rails_admin
      can :read, :dashboard
      can :edit, User, id: user.id
      can :read, User, role: :customer
      can :manage, Booking
      can :manage, Payment
      can :manage, Room
      can :manage, RoomType
      cannot %i(destroy create new), Payment
    end
  end
end
