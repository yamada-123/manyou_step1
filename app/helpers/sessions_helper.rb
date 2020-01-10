module SessionsHelper
  def current_user #ログイン中のユーザ情報を取得するメソッドのこと
    @current_user || @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in? #ユーザーがログインしていればtrueを返す
    current_user.present?
  end

  def log_in(user)   
    binding.pry                                               # 引数(ユーザ)でログイン
    session[:user_id] = user.id
  end
end
