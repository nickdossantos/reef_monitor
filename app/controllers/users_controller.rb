class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = @user.users
    render layout: false
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = user.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = user.new(user_params)
    @user.user_id = @user.id
    respond_to do |format|
      if @user.save
        format.js { }
      else
        format.js { render :new }
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.js {}
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.js { }
    end
  end

  def raspberry_pi
    @user = User.friendly.find(params[:user_id])
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :sms_number, :time_zone)
    end
end
