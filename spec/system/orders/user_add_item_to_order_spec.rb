require 'rails_helper'

describe "Usuário adiciona itens ao pedido" do
  it "com sucesso" do
    # Arrange - criar um usuário, 2 produtos, criar um pedido do usuário
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    product_a = ProductModel.create!(name: 'Produto A', weigth: 15, width: 10, heigth: 20, depth: 30, sku: 'PRODUTO-A', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weigth: 15, width: 10, heigth: 20, depth: 30, sku: 'PRODUTO-B', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'Produto A', from: 'Produto'
    fill_in "Quantidade",	with: '8'
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '8 x Produto A'
  end

  it "e não vê produtos de outro fornecedor" do
    # Arrange - criar 2 fornecedores
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier_a = Supplier.create!(corporate_name: 'ACME Ltda', brand_name: 'ACME', registration_number: '33333333/2000-50',
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                                email: 'contato@acme.com')
    supplier_b = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    product_a = ProductModel.create!(name: 'Produto A', weigth: 15, width: 10, heigth: 20, depth: 30, 
                                      sku: 'PRODUTO-A', supplier: supplier_a)
    product_b = ProductModel.create!(name: 'Produto B', weigth: 15, width: 10, heigth: 20, depth: 30, 
                                      sku: 'PRODUTO-B', supplier: supplier_b)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'

    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B' 
  end
  
  
end