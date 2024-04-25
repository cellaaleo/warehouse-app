require 'rails_helper'

describe "Usuário vê os próprios pedidos" do
  it "e deve estar autenticado" do
    # Arrange
    # Act
    visit root_path
    click_on 'Meus Pedidos'
    
    # Assert
    expect(current_path).to eq new_user_session_path  
  end
  
  it "e não vê outros pedidos" do
    # Arrange - criar 2 users, e 3 pedidos
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    luis = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    #
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: luis, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU00500')
    third_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    # Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
  
end
