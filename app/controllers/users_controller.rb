# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy follow unfollow]
  before_action :current_user, except: :new
  before_action :authenticate_user, except: %i[new create]

  # GET /users
  # GET /users.json
  def index
    @users = User.where.not(id: @current_user.id)
  end

  def home
    # get array of all statuses
    @status_array = []
    @current_user.followings.each do |user|
      next if user.statuses.empty?

      user.statuses.each do |status|
        @status_array << status
      end
    end
    @status_array.sort_by(&:updated_at).reverse! unless @status_array.empty?
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @followed = @current_user.followings.include? @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render 'index' if @current_user.id != @user.id
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = user_params[:password_hash]
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @current_user.id != @user.id
      render 'index'
    else
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @current_user.id != @user.id
      redirect_to users_path
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  # POST /users/user_id/follow
  def follow
    @followership = Followership.new(follower_user: @current_user, followed_user: @user)
    @followership.save
    redirect_to @user
  end

  def unfollow
    @followership = Followership.where(follower_user_id: @current_user.id, followed_user: @user.id)[0]
    @followership.destroy!
    redirect_to @user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password_hash)
  end
end
