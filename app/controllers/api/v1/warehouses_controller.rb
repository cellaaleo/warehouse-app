class Api::V1::WarehousesController < ActionController::API
  def show
    #warehouse = Warehouse.find(params[:id]) => se não encontra, dispara um erro
    #warehouse = Warehouse.find_by(id: params[:id]) => mas o find é melhor
    #return render status: 404 if warehouse.nil?
    #render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    # Lidando com erros do ruby:
    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    rescue
      return render status: 404
    end
  end

  def index
    warehouses = Warehouse.all 
    render status: 200, json: warehouses
  end
end