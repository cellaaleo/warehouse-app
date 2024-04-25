class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end
  
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    # @order.save! => A validação falhou: User é obrigatório(a)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.all # pois Failure/Error: <%= f.collection_select :warehouse_id, @warehouses, :id, :full_description %>
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível registrar o pedido'
      render :new
    end
    
      
    # no redirect_to @objeto, o rails vai encaminhar para o show do objeto (orders/id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params["query"]
  
    @orders = Order.where("code LIKE ?", "%#{@code}%") 
    # Obs.: o where traz um array de itens encontrados. Por isso, aqui usamos a variável no plural (@orders)
  end
end