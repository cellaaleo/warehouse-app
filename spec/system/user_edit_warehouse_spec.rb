require 'rails_helper'

describe 'Usuário edita de um galpão' do  #ao clicar no nome do galpão
  it 'a partir da página de detalhes' do
    #Arrange: criar um galpão no banco de dados
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    #Act: abrir a app, visitar o galpão, clicar em editar
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    #garantir que o formulário aparece
    expect(page).to have_content 'Editar galpão'
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Descrição', with: 'Galpão destinado a cargas internacionais')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Área', with: '100000')
  end

  it 'com sucesso' do
    #Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    #Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Área', with: '200000'
    fill_in 'Endereço', with: 'Avenida dos Galpões, 1500'
    fill_in 'CEP', with: '16000-000'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Nome: Galpão Internacional'
    expect(page).to have_content 'Área: 200000 m2'
    expect(page).to have_content 'Endereço: Avenida dos Galpões, 1500'
    expect(page).to have_content 'CEP: 16000-000'
  end

  it 'com sucesso' do
    #Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    #Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar o galpão'
    expect(page).to have_field('Nome', with: '')
  end
end