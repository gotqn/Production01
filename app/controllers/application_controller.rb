class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  helper_method :get_user_name_by_id, :get_articles_by_id

  rescue_from CanCan::AccessDenied do |exception|

    if exception.action == :show and exception.subject.class.name == 'DemoGem'
      redirect_to new_session_path(User.new)
    else
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  skip_before_filter :verify_authenticity_token, :only => :create

  def get_user_name_by_id(user_id)
    if user_id.nil? or user_id.blank?
      'User was deleted'
    else
      if User.exists?(id: user_id)
        User.find(user_id).login
      else
        'User was deleted'
      end
    end
  end

  def get_articles_by_id(user_id)
    if Article.exists?(user_id: user_id)
      Article.where(user_id: user_id)
    else
      []
    end
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation, :remember_me)
    end

    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:login, :username, :email, :password, :remember_me)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation, :current_password)
    end

  end

  def set_locale

    if current_user
      I18n.locale = current_user.try(:language).downcase || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end

  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

end
