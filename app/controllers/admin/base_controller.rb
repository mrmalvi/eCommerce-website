module Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin!
    before_action :ensure_user_status!

    def authenticate_admin!
      redirect_to root_path unless user_signed_in? && current_user.admin?
    end

    def ensure_user_status!
      if user_signed_in? && !current_user.active?
        flash[:error] = "User has been #{current_user.status.capitalize}!!"
        sign_out(current_user)
        redirect_to root_path
      end
    end
  end
end
