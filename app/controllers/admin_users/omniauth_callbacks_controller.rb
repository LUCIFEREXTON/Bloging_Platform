# app/controllers/users/omniauth_callbacks_controller.rb:

class AdminUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      admin_user = AdminUser.from_omniauth(request.env['omniauth.auth'])

      if admin_user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect admin_user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        redirect_to new_admin_user_session_url, alert: admin_user.errors.full_messages.join("\n")
      end
  end
end