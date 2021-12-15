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
        render json: { success: true, csrf: csrf_token }
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
end