class Api::V1::WarehousesController < Api::V1::ApiController
  def show
    #begin
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    #rescue
    #  return render status: 404
    #end
  end

  def index
    warehouses = Warehouse.all 
    render status: 200, json: warehouses
  end

  def create
    #begin
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) 
    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: {errors: warehouse.errors.full_messages}
    end
    #rescue
    #  render status: 500
    #end
  end
end