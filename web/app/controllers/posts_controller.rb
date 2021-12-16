class PostsController < ActionController::Base
    protect_from_forgery except: :create
    def index
        posts=Post.all
        render json:{
            posts: posts
        }
    end

    def create
        post_create = params.require(:post).permit(:content, :user_id)
        post = Post.new(content: post_create[:content],user_id: post_create[:user_id])
        if post.user_id.blank?
            post.user_id = 0
            post.save!
            render json:{ success: true }
        else
            post.save
            render json:{ errors: "post_create_error" }
        end
    end
end