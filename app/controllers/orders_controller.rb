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
      redirect_to @order, notice: 'Pedido registrado com sucesso'   # no redirect_to @objeto, o rails vai encaminhar para o show do objeto (orders/id)
    else
      @warehouses = Warehouse.all # pois Failure/Error: <%= f.collection_select :warehouse_id, @warehouses, :id, :full_description %>
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível registrar o pedido'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])

    if @order.user != current_user
      redirect_to root_path, alert: 'Você não tem acesso a este pedido'
    end
    
  end

  def search
    @code = params["query"]
  
    @orders = Order.where("code LIKE ?", "%#{@code}%") 
    # Obs.: o where traz um array de itens encontrados. Por isso, aqui usamos a variável no plural (@orders)
  end

  def edit
    @order = Order.find(params[:id])
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order = Order.find(params[:id])
    
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end
  
end