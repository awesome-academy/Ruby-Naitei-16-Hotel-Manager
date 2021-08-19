class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create; end

  def index; end
end
