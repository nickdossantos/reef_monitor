class DashboardController < ApplicationController
  before_action :authenticate_user!
  def show
    @tank = @user.tanks.new
  end
end
