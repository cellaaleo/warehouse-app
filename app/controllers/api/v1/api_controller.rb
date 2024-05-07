class Api::V1::ApiController < ActionController::API
  # a ordem importa. Primeiro declaramos o erro mais genérico e depois o mais específico
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404

  private
  def return_500
    render status: 500
  end

  def return_404
    render status: 404
  end
end