def login(user)
  within('nav') do
    click_on 'Entrar'
  end
  within('form') do
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
  end
end

=begin
Este método de ir clicando e preenchendo campos é lento.
portanto, se houverem muitos testes, vai ser lento demais.
Então o método do devise não precisa dessa rotina toda. Mas para ter sucesso, ele precisa iniciar antes de visitar a tela inicial.
Esse método do devise, pega o usuário, cria a chave que vai deixar o usuário logado por determinado período e joga no navegador
=end