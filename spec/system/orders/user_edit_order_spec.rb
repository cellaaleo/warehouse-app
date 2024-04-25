require 'rails_helper'

describe "Usuário edita pedido" do
  it "e deve estar autenticado" do
    # Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    # Act
    visit edit_order_path(order.id)
    
    # Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it "com sucesso" do
    # Arrange
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    first_supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                      full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                      email: 'contato@dell.com')
    second_supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil Ltda', brand_name: 'Spark', registration_number: '30300300/3000-99',
                                      full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', 
                                      email: 'contato@spark.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: first_supplier, estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in "Data prevista de entrega",	with: "12/12/2025" 
    select 'Spark Industries Brasil Ltda', from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Data prevista de entrega: 12/12/2025'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil Ltda'
  end
  
  it "caso seja o responsável" do
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
    
    # Act
    login_as(luis)
    visit edit_order_path(order.id)
    
    # Assert
    expect(current_path).to eq root_path
  end
end
