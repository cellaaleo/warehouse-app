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
  
  
end
