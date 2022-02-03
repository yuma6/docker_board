class UsersController < ActionController::Base
    protect_from_forgery :except => [:login]
  
    def login
        login_params = params.require(:user).permit(:email, :password)
        user = User.find_by(email: login_params[:email])
    
        if user.nil?
            render json: { result: ['メールアドレスまたはパスワードが間違っています。'] }
            return
        end
    
        unless user.authenticate(login_params[:password])
            render json: { result: ['メールアドレスまたはパスワードが間違っています。'] }
            return
        end
        
        csrf_token = form_authenticity_token
        session[:csrf_token] = csrf_token
        session[:user_id] = user.id
        session[:user_name] = user.name
        render json: { result: ['ログインに成功しました。'], csrf: csrf_token, user_id:user.id, user_name: user.name}
    end

    def create
        user_create = params.require(:user).permit(:name, :email, :password)
        user = User.new(name: user_create[:name],email: user_create[:email],password: user_create[:password])
        if User.find_by(email: user.email)
            render json: { result: ['登録済のメールアドレスです。'] }
            return
        elsif user.save
            render json: { result: ['ユーザー登録成功'] }
            return
        else
            render json: { result: ['ユーザー登録失敗'] }
            return
        end
    end

end