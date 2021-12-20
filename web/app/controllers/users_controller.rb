class UsersController < ActionController::Base
    protect_from_forgery :except => [:login]
  
    def login
        login_params = params.require(:user).permit(:email, :password)
        user = User.find_by(email: login_params[:email])
    
        # メールアドレスで User が特定出来なかった
        if user.nil?
            render json: { errors: ['メールアドレスまたはパスワードが間違っています'] }, status: 404
            return
        end
    
        # パスワードが一致しない
        unless user.authenticate(login_params[:password])
            render json: { errors: ['メールアドレスまたはパスワードが間違っています'] }, status: 404
            return
        end
        
        csrf_token = form_authenticity_token
        session[:csrf_token] = csrf_token
        render json: { success: 'ログインに成功しました', csrf: csrf_token, }
    end

    def me
        if session[:csrf_token].present?
            render json: {
                "me": {
                "id": 1,
                "name": "にんじゃわんこ"
                }
            }
        else
            render json: { errors: ["ログインされていません"] }, status: 404
            return
        end
    end

    def create
        #メールアドレスが同じ場合も登録されないようにする
        user_create = params.require(:user).permit(:name, :email, :password)
        user = User.new(name: user_create[:name],email: user_create[:email],password: user_create[:password])
        if user.save
            render json: { success: 'ユーザー登録成功' }
            return
        else
            render json: { success: ['ユーザー登録失敗'] }
            return
        end
    end

end