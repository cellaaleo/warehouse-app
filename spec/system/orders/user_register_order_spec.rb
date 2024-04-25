require 'rails_helper'

describe 'usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Registrar pedido'
    
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange - user, warehouse, supplier
    user = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
    # galpões na ordem que queremos que apareçam para o testes
    Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                      address: 'Avenida dos Jacarés, 2555', cep: '56000-000',
                      description: 'Galpão no centro do país')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    # foencedores na ordem que queremos (1ºo que não queremos selecionar, 2º o que queremos selecionar)
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678/9000-00',
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão destino'
    select supplier.corporate_name, from: 'Fornecedor'  # Dell Ltda
    fill_in 'Data prevista de entrega', with: '25/04/2025'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Dell Ltda'
    expect(page).to have_content 'Usuário responsável: Carlos - carlos@email.com'
    expect(page).to have_content 'Data prevista de entrega: 25/04/2025'
    #expect(page).to have_content 'Status do pedido: Pendente'
    expect(page).to have_content 'Situação do pedido: Pendente'
    expect(page).not_to have_content 'Cuiabá' # os not_to deixam mais seguros/fortes os testes
    expect(page).not_to have_content 'ACME LTDA'
  end

  it "e não informa data de entrega" do
    # Arrange
    user = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                email: 'contato@dell.com')
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão destino'
    select supplier.corporate_name, from: 'Fornecedor'  # Dell Ltda
    fill_in 'Data prevista de entrega', with: ''
    click_on 'Gravar'

    # Assert 
    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Data prevista de entrega não pode ficar em branco'
  end
  

  #
  #
  # fazer teste de sistema para verificar se a data estimada de entrega é superior à data de pedido!
  #
  #
  
end