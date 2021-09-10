require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}

  describe "validations" do
    it {expect(user).to be_valid}
  end

  describe "associations" do
    it {expect(user).to have_many(:bookings).dependent(:destroy)}
    it {expect(user).to have_many(:reviews).dependent(:destroy)}
    it {expect(user).to have_many(:payments).dependent(:destroy)}
  end

  describe ".new_user" do
    it "return recent new users" do
      month_ago = 6
      users = User.where("created_at >= ?", Time.zone.now - month_ago.months).to_a
      expect(User.new_user(month_ago).to_a).to eq users
    end
  end

  describe ".new_user_by_month" do
    it "return recent new user group by each month" do
      users = User.group_by_month(
        :created_at,
        last: Settings.statistic.default.month_ago,
        format: "%b %Y"
      ).count
      expect(User.new_user_by_month).to eq users
    end
  end
end
