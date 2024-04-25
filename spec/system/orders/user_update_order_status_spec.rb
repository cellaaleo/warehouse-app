require 'rails_helper'

describe "Usuário informa novo status do pedido" do
  it "e pedido foi entregue" do
    # Arrange - criar pedido: status pendente
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: 'pending') #=> apesar de ser padrão, deixamos aqui pela legibilidade
    
    # Act - visualizar pedido e clicar em entregue
    login_as ana
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    # Assert - visualizar novo status
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do pedido: Entregue'
    expect(page).not_to have_button 'Marcar como CANCELADO'  
  end
  
  it "e pedido foi cancelado" do
    # Arrange - criar pedido: status pendente
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: 'pending') #=> apesar de ser padrão, deixamos aqui pela legibilidade
    
    # Act - visualizar pedido e clicar em entregue
    login_as ana
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert - visualizar novo status
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do pedido: Cancelado'
    expect(page).not_to have_button 'Marcar como ENTREGUE'  
  end
  
end
