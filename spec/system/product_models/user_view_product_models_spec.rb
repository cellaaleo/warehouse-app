require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do
    # Arrange -> nada

    # Act -> tentar acessar a tela sem estar autenticado
    visit root_path
    within('nav') do
      click_on 'Modelos de produtos'
    end
    # Assert -> espera ser impedido pelo devise => indo para a tela de login
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Cella', email: 'cella@email.com', password: 'password')
    # Act
    login_as(user)  #método do devise
    visit root_path
    #login(user)
    within('nav') do
      click_on 'Modelos de produtos'
    end

    # Assert
    expect(current_path).to eq(product_models_path)
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Cella', email: 'cella@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Ltda', brand_name: 'Samsung', registration_number: '34333444/3000-40',
                                full_address: 'Av. Nações Unidas, 343', city: 'São Paulo', state: 'SP', email: 'contato@samsung.com.br')
    
    ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, heigth: 45, depth: 10, 
                         sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weigth: 3000, width: 8, heigth: 15, depth: 20, 
                          sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'

    # Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPTO90')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SOU71-SAMSU-NOIZ77')
    expect(page).to have_content('Samsung')
  end

  it 'e não existem produtos cadastrados' do
    # Arrange
    user = User.create!(name: 'Cella', email: 'cella@email.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'

    # Assert
    expect(page).to have_content('Nenhum modelo de produto cadastrado')
  end
end