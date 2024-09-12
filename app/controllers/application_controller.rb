class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource&.admin?
      stored_location_for(resource) || admin_products_path
    else
      root_path
    end
  end
end
