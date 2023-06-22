# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    users_my_page_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

    def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
   @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
      return if !@user
       ##【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別し、そのアカウントが退会しているか（is_deleted==true）
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        ## 【処理内容3】
        redirect_to new_user_session_path
      end
    end

end
