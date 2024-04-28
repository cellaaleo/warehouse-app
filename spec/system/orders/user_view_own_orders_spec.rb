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
    first_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: 'pending')
    second_order = Order.create!(user: luis, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: 'delivered')
    third_order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.week.from_now, status: 'canceled')

    # Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content second_order.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'
  end
  
  it "e visita um pedido" do
    ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    # Act
    login_as(ana)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content 'Detalhes do pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Dell Ltda'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data prevista de entrega: #{formatted_date}"
  end
  
  it "e não visita pedidos de outros usuários" do
     # Arrange - criar 2 users, e 3 pedidos
     ana = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
     luis = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
     warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                   description: 'Galpão destinado a cargas internacionais')
     supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                 full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                 email: 'contato@dell.com')
     order = Order.create!(user: ana, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         #allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU00500')
     # Act
     login_as(luis)
     visit order_path(order.id)
 
     # Assert
     expect(current_path).not_to eq order_path(order.id)
     expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem acesso a este pedido'  
  end
  
  it "e vê itens do pedido" do
    # Arrange - criar produtos A, B e C, criar um pedido e vincular produtos A e B ao pedido
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    product_a = ProductModel.create!(name: 'Produto A', weigth: 15, width: 10, heigth: 20, depth: 30, sku: 'PRODUTO-A', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weigth: 15, width: 10, heigth: 20, depth: 30, sku: 'PRODUTO-B', supplier: supplier)
    product_c = ProductModel.create!(name: 'Produto C', weigth: 15, width: 10, heigth: 20, depth: 30, sku: 'PRODUTO-C', supplier: supplier)

    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    ##### novo model que criaremos
    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert - Ver os produtos A e B, e não ver o produto C
    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'
  end
  
end
