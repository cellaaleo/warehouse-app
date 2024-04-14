class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @product_models = ProductModel.all
  end

  def new 
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
    else
      @suppliers = Supplier.all 
        #=> aqui e não fora o IF pois essa @var não precisa ser carregada se td for preenchido corretamente
        #=> aqui para não dar problema ao fazer render pois o collection_select  precisa dessa @var
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto'
      render 'new'  # => o render converte o arquivo de view para uma string cheia de html
    end
  end

  def show
    set_product_model
  end

  private
  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :weigth, :width, :heigth, 
                                          :depth, :sku, :supplier_id)
  end
end