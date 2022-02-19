class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :articles, class_name: "article", foreign_key: "reference_id"

  before_save :make_password_digest

  def make_password_digest
    self.password_digest = encrypted_password
  end
end
