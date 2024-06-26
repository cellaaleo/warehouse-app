require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Cella', email: 'cella@email.com', password: 'password')

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
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Cella - cella@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end


  it 'e faz logout' do
    # Arrange
    User.create!(email: 'cella@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'cella@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'cella@email.com'
  end
end
