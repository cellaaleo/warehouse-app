require 'rails_helper'

describe "Usuário busca por um pedido" do
  
  it "a partir do menu" do
    # Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    # Assert
    within('header nav') do   #=> lembrar que é um seletor css
      expect(page).to have_field 'Buscar pedido' #=> input
      expect(page).to have_button 'Buscar'  #=> botão
    end
  end

  it "e deve estar autenticado" do
    # Arrange
    
    # Act
    visit root_path
    # Assert
    within('header nav') do
      expect(page).not_to have_field 'Buscar pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end
  
  it "e encontra um pedido" do
    # Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    fill_in "Buscar pedido",	with: order.code
    click_on 'Buscar'
    # Assert
    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão destino: #{warehouse.full_description}"
    expect(page).to have_content "Fornecedor: #{supplier.corporate_name}"
  end
  
  it "e encontra múltiplos pedidos" do
    # Arrange
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado a cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Aeroporto RIO', code: 'SDU', city: 'Rio de Janeiro', area: 125_000,
                                          address: 'Avenida do Porto, 850', cep: '25000-000',
                                          description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    fill_in "Buscar pedido",	with: 'GRU'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'GRU12345'
    expect(page).to have_content 'GRU98765'
    expect(page).to have_content 'Galpão destino: GRU - Aeroporto SP'
    expect(page).not_to have_content 'SDU00000'
    expect(page).not_to have_content 'Galpão destino: SDU - Aeroporto RIO'
  end
  
end
