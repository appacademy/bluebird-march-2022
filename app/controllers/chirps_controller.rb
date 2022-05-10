class ChirpsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create, :index, :show]

    def index
		if params[:user_id]
			@chirps = Chirp.where(author_id: params[:user_id]).includes(:author)
		else
			@chirps = Chirp.all.includes(:author)
		end

		render :index
    end 

    def new
        @chirp = Chirp.new
        render :new
    end

    def show
        @chirp = Chirp.find(params[:id])
        render :show
    end

    def chirp_params
        params.require(:chirp).permit(:body)
    end

    def create
        @chirp = Chirp.new(chirp_params)
        # We dont want to immediate save the chirp to the database with create, because we want to in control of what happens if
        # it succeeds or fails. We'll use some good old fashioned if else logic to decide what to do

        # need to add the below line so we can create a chirp (we'll first get an error without it)
        # @chirp.author = User.first # temporary fix until we have notion of who the current user actually it
        # @chirp.author_id = User.first.id # equivalent
        
        @chirp.author_id = current_user.id

        if @chirp.save
            # If it is successful, let's show the chirp (but to keep things DRY, use our show action)
            redirect_to chirp_url(@chirp) # redirect initiates a whole new request! --> a 'GET' request to the specified url
        else
            # When it comes to errors, we want to be descriptive for our users, so we can use
            # .errors.full_messages to grab the errors we received from the failed save. We will also add a status code to our response
            # render json: @chirp.errors.full_messages, status: :unprocessable_entity # or 422 status code error
            flash.now[:errors] = @chirp.errors.full_messages
            render :new
        end
    end

    def update
        # update looks similiar to the creat action, but instead of instantiating a new chirp to save to the database,
        # We'll lookup the chirp we want to update in the database using the wildcard from the URL, which we can
        # find in the params object

        @chirp = Chirp.find(params[:id])
        if @chirp.update(chirp_params)
            redirect_to chirp_url(@chirp)
        else
            render json: @chirp.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        @chirp = Chirp.find(params[:id])
        @chirp.destroy
        redirect_to chirps_url
    end

end