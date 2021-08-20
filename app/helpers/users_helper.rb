module UsersHelper
  def select_gender
    User.genders.map{|s| [t(".#{s[0]}"), s[0]]}
  end

  def select_role
    User.roles.map{|s| [t(".#{s[0]}"), s[0]]}
  end
end
