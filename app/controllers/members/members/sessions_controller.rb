# frozen_string_literal: true

class Members::Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  protected
  def after_sign_in_path_for(resource)
    root_path
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_member
    @member = Member.find_by(email: params[:member][:email].downcase)
    if @member
      if (@member.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == true))
        flash[:error] = "退会済みです。"
        redirect_to root_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end
end
