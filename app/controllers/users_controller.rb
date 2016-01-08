class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        @user.name = @user.email
        if @user.save
            redirect_to root_url, notice: "Welcome to the site!"
        else
            render 'new'
        end
    end
    
    def show
        @user = User.find(params[:id])
        user_ids = @user.timeline_user_ids
        @posts = Post.where(user_id: user_ids).order("created_at DESC")
    end

    def follow
        @user=User.find(params[:id])
        if current_user.follow!(@user)
            redirect_to @user, notice: "Follow success"
        else
            redirect_to @user, notice: "Error following"
        end
    end

    private
    def user_params
        params.require(:user).permit(:name,
                                     :email,
                                     :password,
                                     :password_confirmation)
    end
end
