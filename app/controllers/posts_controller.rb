class PostsController < ApplicationController

    def index
        @posts = Post.all
    end

    def new 
        @post = Post.new
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end
    
    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to "/posts/#{@post.id}"
        else
            render :new
        end

    end

    def show
        @post = Post.find(params['id'])
    end

    def edit
        @post = Post.find(params['id'])
    
    end

    def update

        @post = Post.find(params['id'])
        if @post.update(post_params)
            redirect_to "/posts/#{@post.id}"
        else
            render "/posts/#{@post.id}/edit"
        end
    end

    def destroy
        @post = Post.find(params['id'])
        @post.destroy
        redirect_to '/posts'

    end

end 