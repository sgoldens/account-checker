class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :searches

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
