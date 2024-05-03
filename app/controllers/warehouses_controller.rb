class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    # retorna um have onde cada key é um objeto (agrupado) e seus  values são a quantidade de cada objeto (de cada product model)
    @product_models = ProductModel.all
    # melhorar o filtro para localizar apenas os product models que estão no galpão
  end 

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save  # => executa o .valid? => preenche o array de erros
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão'
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy #ou @warehouse.delete
    redirect_to root_path, notice: 'Galpão removido com sucesso'
  end

  private 
  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
  
  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) 
    #strong parameters => parâmetros fortes/seguros
  end
end

=begin
  Os strong params permite filtrar as informações enviadas pelo usuários
pois é possível que modifiquem o formulário pela inspeção da página.
  Assim, devemos declarar os params ANTES de fazer o .save ou o .update
para que o Rails filtre e exclua dados não permitidos.
  O usuário pode querer burlar, se cadastrando como admin, pode tentar
colocar um desconto não válido etc.
  Os params do create e do update podem ser diferentes (se quiser impedir, 
por exemplo de se alterar o CPF depois do cadastro). Então reaproveitá-lo
pode não ser uma boa prática
=end