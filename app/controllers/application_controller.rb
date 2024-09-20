class ApplicationController < ActionController::Base
  include PostOwnerActivity
  include ActiveStorage::SetCurrent
  def after_sign_in_path_for(resource)
    if user_signed_in? && !resource.active?
      flash.clear
      flash[:error] = "User has been #{resource.status.capitalize}!!"
      sign_out(resource)
      root_path
    elsif resource.is_a?(User) && resource&.admin?
      post_owner_activity(resource)
      stored_location_for(resource) || admin_products_path
    else
      root_path
    end
  end
end
