# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(id: current_user&.id)
    user.update(current_sign_in_at: DateTime.now)
    broadcast_now

    redirect_to root_path
  end

  # DELETE /resource/sign_out
  def destroy
    user = User.find_by(id: current_user&.id)
    user.update(last_sign_in_at: DateTime.now)
    broadcast_now

    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
