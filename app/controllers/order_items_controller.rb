class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id]) # pois  /orders/:order_id/order_items/new(.:format)
    #@products = ProductModel.all
    @products = @order.supplier.product_models

    @order_item = OrderItem.new
  end

  def create
    @order = Order.find(params[:order_id])
    order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)

    #@order_item = OrderItem.new(order_item_params)
    #@order_item.order = @order
    #@order_item.save
    # ---- por conta da associação, substituímos essas 3 linhas por:
    @order.order_items.create(order_item_params)

    redirect_to @order, notice: 'Item adicionado com sucesso'
  end
  
end