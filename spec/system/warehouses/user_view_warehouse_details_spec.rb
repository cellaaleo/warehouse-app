require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do  #ao clicar no nome do galpão
  it 'e vê informações adicionais' do
    # Arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado a cargas internacionais')
    w.save()   #--> estas duas linhas podem ser substituidas pelo Warehouse.create(...)
    
    # Act
    visit(root_path)
    click_on('Aeroporto SP')

    # Assert    -> obs.: a ordem não importa. O teste procura tudo, independentemente.
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado a cargas internacionais')
  end

  it 'e volta pra tela inicial' do
    # Arrange
    w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado a cargas internacionais')
    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(root_path)
  end
end