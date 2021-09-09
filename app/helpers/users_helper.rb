module UsersHelper
  def select_gender
    User.genders.map{|s| [t(".#{s[0]}"), s[0]]}
  end

  def select_default_ava user
    user.male? ? Settings.default_ava.male : Settings.default_ava.female
  end
end
