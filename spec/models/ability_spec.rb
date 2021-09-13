require "cancan/matchers"
require "rails_helper"

RSpec.describe Ability, type: :model do
  context "when user is admin" do
    before do
      @user = FactoryBot.create :user
      @user.update role: :admin
      @ability = Ability.new @user

    end
    describe "should allow management of users" do
      it "should access rails admin " do
          @ability.should be_able_to :access, :rails_admin
      end
      it "should read dassboard" do
          @ability.should be_able_to :read, :dashboard
      end
      it "should manage all" do
          @ability.should be_able_to :manage, :all
      end
      it "should not destroy create new Payment" do
          @ability.should_not be_able_to %i(destroy create new), Payment
      end
    end
  end

  context "when user is staff" do
    before do
      @user = FactoryBot.create :user
      @user.update role: :staff
      @ability = Ability.new @user

    end
    describe "should allow management of users" do
      it "should access rails admin " do
          @ability.should be_able_to :access, :rails_admin
      end
      it "should read dassboard" do
          @ability.should be_able_to :read, :dashboard
      end
      it "should edit his self" do
          @ability.should be_able_to :edit, @user
      end
      it "should read user customer" do
          @ability.should be_able_to :read, User, role: :customer
      end
      it "should manage Bokking" do
          @ability.should be_able_to :manage, Booking
      end
      it "should manage Payment" do
          @ability.should be_able_to :manage, Payment
      end
      it "should manage rooom" do
          @ability.should be_able_to :manage, Room
      end
      it "should manage room type" do
          @ability.should be_able_to :manage, RoomType
      end
      it "should not destroy create new Payment" do
          @ability.should_not be_able_to %i(destroy create new), Payment
      end
    end
  end

end
