# frozen_string_literal: true

class Front::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
     respond_with resource, location: after_sign_in_path_for(resource)
  end

  def failed
    flash[:sign_in_error] = flash[:alert]
    redirect_to front_post_images_path
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failed" }
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
