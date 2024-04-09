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
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) #strong parameters => parâmetros fortes/seguros
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save  # => executa o .valid? => preenche o array de erros
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
    
  end
end