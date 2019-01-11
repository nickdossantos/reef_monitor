class PagesController < ApplicationController
  def homepage
  end

  def tanks
    @tanks = @user.tanks
  end
end
