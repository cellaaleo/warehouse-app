class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    #aqui dentro que iremos:
    # 1- Receber os dados enviados
    # 2- Criar um novo galpão no banco de dados
      #Parameters: {"authenticity_token"=>"[FILTERED]", "warehouse"=>{"name"=>"Rio de Janeiro", "description"=>"galpão do RIO", "code"=>"RIO", "address"=>"Av Museu, 1000", "city"=>"Rio de Janeiro", "cep"=>"20100-000", "area"=>"1000"}, "commit"=>"Enviar"}
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) #strong parameters => parâmetros fortes/seguros
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
    
  end
end