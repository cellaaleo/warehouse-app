require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um número de série" do
    it "ao criar um StockProduct" do
      # Arrange
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
        description: 'alguma descrição', address: 'Endereço', cep: '25000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
            full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
            email: 'contato@dell.com')
      product = ProductModel.create!(supplier: s, name: 'cadeira gamer', weigth: 5, width: 70, 
                                      heigth: 100, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
      
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: w, product_model: product)
      # Assert
      expect(stock_product.serial_number.length).to eq 20
    end
    
    it "e não é modificado" do
      # Arrange
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
        description: 'alguma descrição', address: 'Endereço', cep: '25000-000', area: 1000)
      other_w = Warehouse.create!(name:'Galpão GRU', code:'GRU', city: 'Guarulhos', 
          description: 'alguma descrição', address: 'Endereço', cep: '01000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
            full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
            email: 'contato@dell.com')
      product = ProductModel.create!(supplier: s, name: 'cadeira gamer', weigth: 5, width: 70, 
                                      heigth: 100, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
      stock_product = StockProduct.create!(order: order, warehouse: w, product_model: product)
      original_serial_number = stock_product.serial_number

      # Act
      stock_product.update!(warehouse: other_w)
      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
    
  end
    
end
