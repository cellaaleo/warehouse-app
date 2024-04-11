require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    # Arrange: criar um fornecedor
    supplier = Supplier.create!(corporate_name: 'Samsung Ltda', brand_name: 'Samsung', 
                                registration_number: '34333444/3000-40',
                                full_address: 'Av. Nações Unidas, 343', city: 'São Paulo', 
                                state: 'SP', email: 'contato@samsung.com.br')
    other_supplier = Supplier.create!(corporate_name: 'LG Ltda', brand_name: 'LG', 
                                registration_number: '78777888/7000-80',
                                full_address: 'Av. Ibirapuera, 787', city: 'São Paulo', 
                                state: 'SP', email: 'contato@lg.com.br')
    # Act
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: 'TV 40 Polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-XPTO'
    select 'Samsung', from: 'Fornecedor' 
    #select supplier.brand_name, from: 'Fornecedor'  ==> outra possibilidade
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Modelo de produto cadastrado com sucesso')
    expect(page).to have_content('TV 40 Polegadas')
    expect(page).to have_content('Fornecedor: Samsung')
    #expect(page).to have_content("Fornecedor: #{supplier.brand_name}")  ==> outra possibilidade
    expect(page).to have_content('SKU: TV40-SAMS-XPTO')
    expect(page).to have_content('Dimensões: 60cm x 90cm x 10cm')
    expect(page).to have_content('Peso: 10000g')
  end

  it 'e deve preencher todos os campos' do
    # Arrange: criar um fornecedor
    supplier = Supplier.create!(corporate_name: 'Samsung Ltda', brand_name: 'Samsung', 
                                registration_number: '34333444/3000-40',
                                full_address: 'Av. Nações Unidas, 343', city: 'São Paulo', 
                                state: 'SP', email: 'contato@samsung.com.br')
    
    # Act
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível cadastrar o modelo de produto')
    
  end
end