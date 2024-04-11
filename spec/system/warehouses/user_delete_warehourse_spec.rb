require 'rails_helper'

describe 'Usuário remove um galpão' do
  it '' do
    # Arrange - criar um galpão
    warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                                  address: 'Avenida dos Jacarés, 2555', cep: '56000-000',
                                  description: 'Galpão no centro do país')
           
    # Act - visitar tela inicial, abrir o galpão, clicar em remover
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert - espero que o galpão não apareça na página inicial
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    # Arrange
    first_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                                  address: 'Avenida dos Jacarés, 2555', cep: '56000-000',
                                  description: 'Galpão no centro do país')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20000,
                                  address: 'Avenida Tiradentes, 3333', cep: '44000-000',
                                  description: 'Galpão de cargas mineiras') 
    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'
    
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'
  end
end