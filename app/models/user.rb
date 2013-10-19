class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation

  validates_presence_of :email, :password_digest, unless: :guest?
#  validates_uniqueness_of :username, allow_blank: true
 # validates_confirmation_of :password

  # override has_secure_password to customize validation until Rails 4.
  require 'bcrypt'
  attr_reader :password
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
    "Guest"
  end

  def move_to(user)
    tasks.update_all(user_id: user.id)
  end
  #attr_accessible :email, :password_digest
end
