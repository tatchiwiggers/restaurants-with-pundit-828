class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:github_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:github_name])
  end

  include Pundit

  # Pundit: abordagem TUDO é proibido.
  # o que significa que toda ação será negada a menos que eu permita explicitamente
  # então após cada ação, um método chamado :verify_authorized será chamado
  # que chamará pundit - para todas as ações, exceto :index, a menos que vocês utilizem
  # skip pundit?, que é este método privado aqui que afirma que, se você estiver
  # no controller do devise (ou seja, se você tiver um usuário que precisa se inscrever)
  # ou se você estiver no administrador ou nas páginas do controlador, pule o pundit
  # ainda não temos um controlador de administração, mas veremos isso mais tarde na aula
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
