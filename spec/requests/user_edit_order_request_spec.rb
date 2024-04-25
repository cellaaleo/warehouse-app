require 'rails_helper'

describe "Usuário edita um pedido" do
  it "e não está autenticado" do
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    # Act - não usaremos o capybara, portanto não usaremos o visit. Usaremos um protocolo http
    patch(order_path(order.id), params: {order: {supplier_id: 3}})
    
    # Assert
    expect(response).to redirect_to(new_user_session_path)  
  end
  
  it "e não é o responsável" do
    # Arrange
    luis = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    # Act - não usaremos o capybara, portanto não usaremos o visit. Usaremos um protocolo http
    login_as(luis)
    patch(order_path(order.id), params: {order: {supplier_id: 3}})
    
    # Assert
    expect(response).to redirect_to(root_path)  
  end
  
end
