require 'rails_helper'

#cenário de teste: (o describe deve ter um nome que costuma seguir o nome do arquivo)
describe 'Usuário visita tela inicial' do 
  it 'e vê o nome da app' do
    # ARRANGE

    # ACT
    visit(root_path)

    # ASSERT
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    # ARRANGE
    #cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000)

    # ACT
    visit(root_path)

    # ASSERT
    #garantir que eu veja na tela os galpoes Rio e Maceio
    expect(page).not_to have_content('Não existem galpões cadastrados.')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end # o rails entende ser teste e, quando um teste específico termina, os galpões aqui criados são apagados. 
      # Assim, o teste a seguir ocorrerá sem necessidade de apagar manualmente os cadastros.

  it 'e não existem galpões cadastrados' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados.')
  end
end

#o arquivo de teste tem que terminar com '_spec.rb' pra ser reconhecido

# ARRANGE --> no 1º teste, pode estar vazio pois é apenas o de abrir a aplicação

# visit é um método de sistema que vai abrir uma página. No caso, o caminho é a página inicial
# o rspec capybara vai abrir o navegador de mentirinha e vai acessar o localhost:3000/ e vai dar 'enter'

#expect(page) --> O assert vai ser cheio de expects. O método visit, vê uma página.

