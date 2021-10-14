class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_destroy :one_administrator_required
  has_many :tasks, dependent: :destroy
  # after_update :admin_update_exist
  before_update :admin_update_exist

  private
  def one_administrator_required
    errors.add :admin
    throw(:abort) if User.where(admin: true).length == 1 && self.admin?
  end

  def admin_update_exist
    errors.add :admin
    if User.where(admin: true).length == 1
      if User.where(admin: true).first.id == self.id
        if self.admin? == false
          throw(:abort)
        end
      end
    end
  end
  # def admin_update_exist
  #   errors.add :admin
  #   if User.where(admin: true).length == 0
  #     raise ActiveRecord::Rollback
  #   end
  # end
end
