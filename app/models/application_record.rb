class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :recent_first, -> { order(created_at: :desc) }
end
