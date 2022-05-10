class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    def new
        @user = User.new
        render :new
    end

    def create
        # debugger
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        # debugger
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            # we need some errors
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end
    end 

    def destroy
        logout!
        flash[:success] = ["Successfully logged out!"]
        redirect_to new_session_url
    end
end
