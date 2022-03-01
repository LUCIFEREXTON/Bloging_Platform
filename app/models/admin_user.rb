class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
         
  def from_omniauth(auth)
    admin_user = where(email: auth.info.email).first || where(auth.slice(:provider, :uid).to_h).first || new
    admin_user.tap { |this| this.update_attributes(provider: auth.provider, uid: auth.uid, email: auth.info.email) }
  end
end
