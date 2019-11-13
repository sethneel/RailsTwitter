# frozen_string_literal: true

class StatusesController < ApplicationController
  before_action :set_user, :authenticate_user, :current_user
  before_action :set_status, only: %i[show edit update destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = @user.statuses.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show; end

  # GET /statuses/new
  def new
    @status = @user.statuses.build
  end

  # GET /statuses/1/edit
  def edit
    render 'index' if @current_user.id != @user.id
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = @user.statuses.build(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to user_status_path(@user, @status), notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: user_status_path(@user, @status) }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    if @current_user.id != @user.id
      render 'index'
    else
      respond_to do |format|
        if @status.update(status_params)
          format.html { redirect_to user_status_path(@user, @status), notice: 'Status was successfully updated.' }
          format.json { render :show, status: :ok, location: user_status_path(@user, @status) }
        else
          format.html { render :edit }
          format.json { render json: @status.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    if @current_user.id != @user.id
      render 'index'
    else
      @status.destroy
      respond_to do |format|
        format.html { redirect_to user_statuses_path(@user), notice: 'Status was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_status
    @status = Status.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def status_params
    params.require(:status).permit(:content)
  end
end
