class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 'user', admin: 'admin' }
  enum status: { active: 'active', inactive: 'inactive', banned: 'banned' }

  before_create :set_default_role

  def email_required?
    false
  end

  def password_required?
    false
  end

  private
    def set_default_role
      self.role ||= :user
    end
end
