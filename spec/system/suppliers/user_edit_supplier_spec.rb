require 'rails_helper'

describe 'Usuário edita dados de um fornecedor' do
  it 'a partir da página de detalhes' do
    #Arrange: criar um fornecedor no banco de dados
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', email: 'contato@dell.com')
    #Act: abrir a app, clicar em fornecedores, clicar em Dell, clicar em editar
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Dell'
    click_on 'Editar'

    #Assert
    expect(page).to have_content('Editar fornecedor')
    expect(page).to have_field('Nome fantasia', with: 'Dell')
    expect(page).to have_field('Razão Social', with: 'Dell Ltda')
    expect(page).to have_field('CNPJ', with: '25222555/2000-50')
    expect(page).to have_field('Endereço', with: 'Av. Industrial Belgraf, 400')
    expect(page).to have_field('Cidade', with: 'Eldorado do Sul')
    expect(page).to have_field('Estado', with: 'RS')
    expect(page).to have_field('E-mail', with: 'contato@dell.com')
  end

  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', email: 'contato@dell.com')
    #Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Dell'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'Dell do Brasil'
    fill_in 'Razão Social', with: 'Dell do Brasil Ltda'
    fill_in 'E-mail', with: 'contato@dell.com.br'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Dell do Brasil')
    expect(page).to have_content('CNPJ: 25222555/2000-50')
    expect(page).to have_content('Endereço: Av. Industrial Belgraf, 400 - Eldorado do Sul - RS')
    expect(page).to have_content('E-mail: contato@dell.com.br')
  end

  it 'com dados incompletos' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', email: 'contato@dell.com')
    #Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Dell'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Não foi possível atualizar o fornecedor')
    expect(page).to have_field('Nome fantasia', with: '')
  end
end