class PostsController < ActionController::Base
    # protect_from_forgery except: :create
    def index
        posts=Post.all
        render json:{
            posts: posts,
            "session": session
        }
    end

    def create
        post_create = params.require(:post).permit(:content, :user_id)
        post = Post.new(content: post_create[:content],user_id: post_create[:user_id])
        if post.save
            render json:{ success: true }
        else
            render json:{ errors: "post_create_error" }
        end
    end
end