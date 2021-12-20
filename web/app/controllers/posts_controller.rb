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
        if post.content.blank?
            render json:{ success: '投稿内容が空です'}
        elsif post.save
            #ログイン中ユーザーのidを持たせた後再確認すること
            post.save
            render json:{ success: '投稿に成功しました' }
        else
            post.user_id = 0
            post.save
            render json:{ success: "投稿に成功しました(user_id=0)" }
        end
    end
end