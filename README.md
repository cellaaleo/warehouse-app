# README

Aplicação desenvolvida ao longo de curso de Ruby on Rails com TDD

## Links sugeridos para estudo:

O quê é o Rails? Como instalar Rails
- [Site oficial do Rails](https://rubyonrails.org/)
- [A doutrina do Rails](https://rubyonrails.org/doctrine)
- [RubyGems - O repositório oficial de Gems do Ruby](https://rubygems.org/)

Conceitos-chave: protocolo HTTP
- [Visão geral do protocolo HTTP](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Overview)

Conceitos-chave: Models, Views e Controllers (MVC)
- [Definição de MVC (inglês)](https://developer.mozilla.org/en-US/docs/Glossary/MVC)

Por que escrever testes?
- [Test first (inglês)](http://www.extremeprogramming.org/rules/testfirst.html)

Gems para testes
- [Gem Capybara](https://github.com/teamcapybara/capybara)
- [Gem RSpec Rails](https://github.com/rspec/rspec-rails)

Models e migrations
- [Criando um model](https://guiarails.com.br/getting_started.html#mvc-e-voce-gerando-um-model)
- [Documentação do método link_to](https://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to)

Melhorias no HTML e métodos de Models
- [Layouts e renderização](https://guiarails.com.br/layouts_and_rendering.html)
- [Semântica em HTML](https://developer.mozilla.org/pt-BR/docs/Glossary/Semantics)

Introdução a formulários
- [Meu primeiro formulário](https://developer.mozilla.org/pt-BR/docs/Learn/Forms/Your_first_form)

Form (Cadastrando galpões)
- [Criando um formulário para um Model](https://guiarails.com.br/form_helpers.html#trabalhando-com-objetos-model)

Exibindo mensagens de sucesso
- [HTTP Idempotente](https://developer.mozilla.org/pt-BR/docs/Glossary/Idempotent)
- [A sessão no Rails](https://guiarails.com.br/action_controller_overview.html#sessao)
- [Mensagens Flash](https://guiarails.com.br/action_controller_overview.html#o-flash)

Validação
- [Validações no ActiveRecord](https://guiarails.com.br/active_record_validations.html)

Testes unitários
- [Expectativas no RSpec](https://github.com/rspec/rspec-expectations)
- [Como organizar testes unitários](https://www.betterspecs.org/#describe)
- [Validação Uniqueness](https://guides.rubyonrails.org/active_record_validations.html#uniqueness)

Internacionalização (i18n)
- [Documentação do i18n](https://guides.rubyonrails.org/i18n.html)
- [Gem com traduções oficiais](https://github.com/svenfuchs/rails-i18n)

Update (Editando galpão)
- [Como funciona o update](https://guiarails.com.br/active_record_basics.html#update)

Removendo repetições
- [Before Action](https://guides.rubyonrails.org/action_controller_overview.html#filters)
- [Partial Views](https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)

Delete (Removendo galpões)
- [CRUD](https://developer.mozilla.org/pt-BR/docs/Glossary/CRUD)
- [Delete no Rails](https://guides.rubyonrails.org/active_record_basics.html#delete)
- [Documentação button_to](https://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-button_to)

(outros)
- [Elemento Nav](https://developer.mozilla.org/pt-BR/docs/Web/HTML/Element/nav)
- [Dicas para link_to](https://www.rubyguides.com/2019/05/rails-link_to-method/)

Associações: belongs_to
- [Documentação de Associações]https://guiarails.com.br/association_basics.html)
- [References para migrações](https://guides.rubyonrails.org/active_record_migrations.html#references)

Formulários com associações
- [Select em formulários Rails](https://guides.rubyonrails.org/form_helpers.html#making-select-boxes-with-ease)
- [Documentação do collection_select](https://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select)

Autenticação com Devise
- [RubyToolbox](https://www.ruby-toolbox.com/)
- [Sobre autenticação em aplicações web](https://github.com/heartcombo/devise)
- [gem Devise](https://github.com/heartcombo/devise)
- [Documentação do Devise](https://github.com/heartcombo/devise#getting-started)

Autenticação: logout e cadastro
- [Documentação button_to](https://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-button_to)
- [Estilo de links versus botões](https://css-tricks.com/a-complete-guide-to-links-and-buttons/)
- [Strong Parameters no Devise](https://github.com/heartcombo/devise#strong-parameters)

Bloqueando visitantes em rotas
- [Filters em controllers com Devise](https://github.com/heartcombo/devise#controller-filters-and-helpers)
- [Restrições via rotas no Devise](https://github.com/heartcombo/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb)
- [Métodos para testes com Capybara no Devise](https://github.com/heartcombo/devise/wiki/How-To:-Test-with-Capybara)

Melhorias na exibição de pedidos
- [Métodos para exibição usando i18n](https://dev.to/risafj/the-basics-of-rails-i18n-translate-errors-models-and-attributes-84d#1)
- [Método date_field](https://edgeapi.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-date_field)

Criando um código automático para o pedido
- [Active Record Callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
- [Classe SecureRandom](https://ruby-doc.org/stdlib-2.7.0/libdoc/securerandom/rdoc/SecureRandom.html)
- [RSpec Mocks](https://github.com/rspec/rspec-mocks#method-stubs)

Validações personalizadas
- [Validações personalizadas em Rails](https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations)
- [Documentação da classe ActiveRecord::Errors](https://api.rubyonrails.org/classes/ActiveModel/Errors.html)

Métodos de busca
- [form_with com URL](https://guiarails.com.br/form_helpers.html#formulario-de-pesquisa-generica)
- [Adicionando rotas ao resources](https://guides.rubyonrails.org/routing.html#adding-more-restful-actions)
- [Documentação de métodos de busca do Rails](https://guiarails.com.br/active_record_querying.html#recuperando-objetos-do-banco-de-dados)
- [Método find_by](https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/FinderMethods.html#method-i-find_by)
- [Método where: rubyonrails.org](https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/QueryMethods.html#method-i-where)
- [Método where: rubyguides.com](https://www.rubyguides.com/2019/07/rails-where-method/)
- [Tutoriais de SQL](https://www.w3schools.com/sql/default.asp)

Listando pedidos de um usuário
- [Métodos criados via has_many](https://guiarails.com.br/association_basics.html#referencia-da-associacao-has-many)
- [Partials com objetos de models](https://guides.rubyonrails.org/layouts_and_rendering.html#rendering-collections)

Testes de requisição
- [Testes de Requisição com RSpec Rails](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec)
- [Request specs](https://rspec.info/features/6-0/rspec-rails/request-specs/request-spec/)

Rails Enum
- [Rails Enum - Documentação](https://api.rubyonrails.org/v5.1/classes/ActiveRecord/Enum.html)
- [Rails Enum - Artigo da Campus Code](https://www.campuscode.com.br/conteudos/ruby-on-rails-enum?_gl=1*1i9t5a7*_ga*OTA2MjM0Nzg3LjE2OTMzNDA5NDM.*_ga_BG1H65WPRG*MTcxNDA2ODE3MC4yOTkuMS4xNzE0MDY4MTcyLjAuMC4w)

Associações Rails
- [Documentação de has_many_through](https://guiarails.com.br/association_basics.html#a-associacao-has-many-through)
- [Métodos do has_many](https://guiarails.com.br/association_basics.html#metodos-adicionados-por-has-many)
- [Documentação de Nested Resources](https://guiarails.com.br/routing.html#nested-resources-recursos-aninhados)

Listando estoque de um galpão
- [Método group](https://guides.rubyonrails.org/active_record_querying.html#group)

Saída de itens do estoque
- [Documentação de has_one](https://guides.rubyonrails.org/association_basics.html#the-has-one-association)
- [Documentação sobre associações](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
- [Método 'missing'](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods/WhereChain.html#method-i-missing)