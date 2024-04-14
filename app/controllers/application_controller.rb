class ApplicationController < ActionController::Base
  #before_action :authenticate_user! --> se precisasse de login p/ toda a aplicação, deixaria aqui
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
#copiado da documentação do devise no github