class SessionsController < ApplicationController
    before_action :authenticate_user, only: [:destroy]
    before_action :current_user, only: [:destroy]
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email:params[:email])
        if @user && @user.password == params[:password_hash]
            session[:user_id] = @user.id
            # clear message in case of previous login attempts
            @error_message = nil
            redirect_to user_statuses_path(@user)
        else
            # error message for login page
            @error_message = 'Username or Password Incorrect.'
            @user = User.new
            render 'new'
        end 
    end

    def destroy
        reset_session
        redirect_to '/home'
    end
end 