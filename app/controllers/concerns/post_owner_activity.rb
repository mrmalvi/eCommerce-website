module PostOwnerActivity
  extend ActiveSupport::Concern

  private
    def post_owner_activity(owner)
      WelcomeNotifierJob.perform_in(20.minutes, owner.id) if owner.login_activities.count == 1
    end
end
