require 'rails_helper'

#cenário de teste: (o describe deve ter um nome que costuma seguir o nome do arquivo)
describe 'Usuário visita tela inicial' do 
  it 'e vê o nome da app' do
    # ARRANGE

    # ACT
    visit('/')

    # ASSERT
    expect(page).to have_content('Galpões & Estoque')
  end
end

#o arquivo de teste tem que terminar com '_spec.rb' pra ser reconhecido

# ARRANGE --> neste teste, pode estar vazio, é apenas o de abrir a aplicação

# visit é um método de sistema que vai abrir uma página. No caso, o caminho é a página inicial
# o rspec capybara vai abrir o navegador de mentirinha e vai acessar o localhost:3000/ e vai dar 'enter'

#expect(page) --> O assert vai ser cheio de expects. O método visit, vê uma página.

