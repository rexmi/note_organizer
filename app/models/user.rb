class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ROLES = { 0 => :default, 1 => :admin }

  # attr_reader :role

  # def initialize(email, role_id = 0)
  #   @role = ROLES.has_key?(role_id.to_i) ? ROLES[role_id.to_i] : ROLES[0]
  #   @email = email
  # end

  # def role?(role_title)
  #   self.role == role_title.to_s
  # end

  def admin?
    self.role == 'admin'
  end

end
