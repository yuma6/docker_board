class PostsController < ActionController::Base
    protect_from_forgery except: :create
    def index
        posts=Post.joins(:user).select("posts.*,users.*")
        render json: posts
    end

    def create
        post_create = params.require(:post).permit(:content)
        post = Post.new(content: post_create[:content],user_id: session[:user_id])
        return render json:{ result: ['投稿内容が空です']} if post.content.blank?
        if !post.save
            post.user_id = 0
            post.save
        end
        render json:{ result: ['投稿に成功しました' + "[user_id:#{post.user_id}]"] }
    end

end