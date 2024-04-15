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
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select warehouse.name, from: 'Galpão destino' # Aeroporto SP
    select supplier.corporate_name, from: 'Fornecedor'  # Dell Ltda
    fill_in 'Data prevista de entrega', with: '25/04/2024'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Galpão destino: Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Dell Ltda'
    expect(page).to have_content 'Usuário responsável: Carlos | carlos@email.com'
    expect(page).to have_content 'Data prevista de entrega: 25/04/2024'
    expect(page).not_to have_content 'Cuiabá' # os not_to deixam mais seguros/fortes os testes
    expect(page).not_to have_content 'ACME LTDA'
  end
end