class User < ApplicationRecord
  before_destroy :do_not_destroy_last_admin
  before_update :do_not_update_last_admin

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length:{ minimum:5 }

  has_many :tasks, dependent: :destroy

  has_secure_password

  paginates_per 10

  private

  def do_not_destroy_last_admin
    if self.admin? && User.where(admin: true).count <= 1
      throw(:abort)
    end
  end

  def do_not_update_last_admin
   admin_users = User.where(admin: true)
   if (admin_users.count == 1 && admin_users.first == self) && !(self.admin?)
     throw(:abort)
   end
 end
end
