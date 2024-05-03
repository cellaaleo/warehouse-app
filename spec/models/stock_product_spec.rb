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

  describe "#available?" do
    it "true se não tiver destino" do
      # Arrange
      user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                  full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                  email: 'contato@dell.com')
      product_cadeira = ProductModel.create!(supplier: supplier, name: 'cadeira gamer', weigth: 5, width: 70, 
                                            heigth: 100, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_cadeira)

      # Assert
      expect(stock_product.available?).to eq true
    end

    it "false se tiver destino" do
      # Arrange
      user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                  full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                  email: 'contato@dell.com')
      product_cadeira = ProductModel.create!(supplier: supplier, name: 'cadeira gamer', weigth: 5, width: 70, 
                                            heigth: 100, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_cadeira)
      stock_product.create_stock_product_destination!(recipient: 'José Maria', address: 'Rua do José Maria')
      # Assert
      expect(stock_product.available?).to eq false
    end
    
  end
  
end
