require 'rails_helper'

describe 'Usuário vê fornecedores' do 
  it 'a partir do menu' do
    # ARRANGE

    # ACT
    visit root_path
    within('nav') do # no within podemos usar um seletor css (tag, .class, #id)
      click_on 'Fornecedores'
    end

    # ASSERT  (o expect tb pode usar o within)
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    # ARRANGE - cadastrar 2 fornecedores
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678/9000-00',
                    full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '98765423/1000-00',
                    full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'contato@spark.com')

    # ACT
    visit root_path
    within('nav') do 
      click_on 'Fornecedores'
    end

    # ASSERT - garantir que veja na tela os forncedores ACME e Spark
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'e não existem fornecedores cadastrados' do
    # ARRANGE
    # ACT
    visit root_path
    within('nav') do 
      click_on 'Fornecedores'
    end

    # ASSERT
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end 
end