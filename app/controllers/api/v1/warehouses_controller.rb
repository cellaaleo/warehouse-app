class Api::V1::WarehousesController < ActionController::API
  def show
    #render status: 200, json: "{name: Aeroporto SP}"
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse
  end
end