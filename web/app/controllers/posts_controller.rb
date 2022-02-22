class PostsController < ActionController::Base
    protect_from_forgery except: :create
    def index
        posts=Post.order(id: "DESC").joins(:user).select("posts.*,users.name")
        render json: posts
    end

    def create
        post_create = params.require(:post).permit(:content)
        post = Post.new(content: post_create[:content],user_id: session[:user_id])
        user = session[:user_name]
        return render json:{ message: ['投稿内容が空です。'], result: false} if post.content.blank?
        if !post.save
            postuser=User.find_by(id:0)
            post.user_id = postuser.id
            user = postuser.name
            post.save
        end
        render json:{ message: ['投稿に成功しました。' + "#{user}##{post.user_id}"], result:true, new:post }
    end

end