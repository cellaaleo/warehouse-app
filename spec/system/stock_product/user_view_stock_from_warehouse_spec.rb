require 'rails_helper'

describe "Usuário vê o estoque" do
  it "na tela do Galpão" do
    # Arrange - criar galpão e alguns produtos, criar estoque destes produtos
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    product_cadeira = ProductModel.create!(supplier: supplier, name: 'cadeira gamer', weigth: 5, width: 70, 
                                          heigth: 100, depth: 75, sku: 'CAD-GAMER-1234')
    product_tv = ProductModel.create!(supplier: supplier, name: 'TV 32', weigth: 8000, width: 70, 
                                      heigth: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90')
    product_soundbar = ProductModel.create!(supplier: supplier, name: 'SoundBar 7.1 Surround', weigth: 3000, width: 8, 
                                            heigth: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ77' )
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    #### Assim, não é necessário criar o Orderitems. Passamos a qte diretamente aqui.
    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_cadeira)}
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    
    # Act - visitar o galpão
    login_as user
    visit warehouse_path(warehouse.id)

    # Assert - espero ver quantidade de itens de produtos A e B, e não ver C
    within('section#stock_products') do 
      expect(page).to have_content 'Itens em estoque'
      expect(page).to have_content '3 x CAD-GAMER-1234'
      expect(page).to have_content '2 x TV32-SAMSU-XPTO90'
      expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
    end
  end
  
  it "e dá baixa em um item" do
    # Arrange - criar galpão e alguns produtos, criar estoque destes produtos
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    product_tv = ProductModel.create!(supplier: supplier, name: 'TV 32', weigth: 8000, width: 70, 
                                      heigth: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    
    # Act - visitar o galpão
    login_as user
    visit warehouse_path(warehouse.id)
    select 'TV32-SAMSU-XPTO90', from: 'Item de saída'
    fill_in "Destinatário",	with: "Maria José"
    fill_in "Endereço Destino",	with: "Rua das Palmeiras, 100 - São Paulo/SP"
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x TV32-SAMSU-XPTO90'
  end
  
end
