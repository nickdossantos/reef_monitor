class PagesController < ApplicationController
  layout "tank"
  def homepage
  end

  def tanks
    @tanks = @user.tanks
  end
end
