require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    User.create!(email: 'cella@email.com', password: 'password')

    # Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: 'cella@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_link 'Sair'
      expect(page).to have_content 'cella@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

=begin
  it 'espera ver uma mensagem de sucesso' do
    # Arrange
    User.create!(email: 'cella@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Fazer login'
    fill_in 'E-mail', with: 'cella@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    # Assert
    expect(page).to have_content 'Usuário autenticado com sucesso'
  end
=end
end
