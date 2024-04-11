require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do 
  it 'ao clicar em seu nome' do
    # ARRANGE
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678/9000-00',
                    full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    # ACT
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'ACME'

    # ASSERT  (o expect tb pode usar o within)
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 12345678/9000-00'
    expect(page).to have_content 'Endereço: Av. das Palmas, 100'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end


  it 'e volta para a página inicial' do
    # ARRANGE
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678/9000-00',
                    full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    # ACT
    visit root_path
    within('nav') do # no within podemos usar um seletor css (tag, .class, #id)
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Voltar'

    # ASSERT
    expect(current_path).to eq root_path
  end
end