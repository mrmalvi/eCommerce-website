class WelcomeNotifierJob < ApplicationJob
  def perform(user_id)
    user = User.find_by(id: user_id) || return
    # send notify
    # WelcomeNotifierJob.perform_async(user_id)
  end
end
