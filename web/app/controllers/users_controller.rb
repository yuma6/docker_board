class UsersController < ActionController::Base
    protect_from_forgery :except => [:login]
  
    def login
        login_params = params.require(:user).permit(:email, :password)
        user = User.find_by(email: login_params[:email])
    
        if user.nil?
            render json: { message: ['メールアドレスまたはパスワードが間違っています。'], result: false }
            return
        end
    
        unless user.authenticate(login_params[:password])
            render json: { message: ['メールアドレスまたはパスワードが間違っています。'], result: false }
            return
        end
        
        csrf_token = form_authenticity_token
        session[:csrf_token] = csrf_token
        session[:user_id] = user.id
        session[:user_name] = user.name
        render json: { message: ['ログインに成功しました。'], csrf: csrf_token, user_id:user.id, user_name: user.name, result: true}
    end

    def create
        user_create = params.require(:user).permit(:name, :email, :password)
        user = User.new(name: user_create[:name],email: user_create[:email],password: user_create[:password])
        if User.find_by(email: user.email)
            render json: { message: ['登録済のメールアドレスです。'], result: false }
            return
        elsif user.save
            render json: { message: ['ユーザー登録成功'], result: true }
            return
        else
            render json: { message: ['ユーザー登録失敗'], result: false }
            return
        end
    end

end