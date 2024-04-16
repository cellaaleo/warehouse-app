require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange - criar um pedido com todos os campos menos o código
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
        description: 'alguma descrição', address: 'Endereço', 
        cep: '25000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
            full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
            email: 'contato@dell.com')

      order = Order.new(user: u, warehouse: w, supplier: s, estimated_delivery_date: '2024-10-25')

      # Act - salvar
      result = order.valid?

      # Assert
       expect(result).to be true

    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange - criar um pedido com todos os campos menos o código
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
                                    description: 'alguma descrição', address: 'Endereço', 
                                    cep: '25000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                  full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                  email: 'contato@dell.com')

      order = Order.new(user: u, warehouse: w, supplier: s, estimated_delivery_date: '2024-10-25')

      # Act - salvar
      order.save!
      result = order.code

      # Assert - espero que o pedido tenha um código aleatório
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      # Arrange - criar um pedido com todos os campos menos o código
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
                                    description: 'alguma descrição', address: 'Endereço', 
                                    cep: '25000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
                                  full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
                                  email: 'contato@dell.com')

      first_order = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: '2024-10-25')
      second_order = Order.new(user: u, warehouse: w, supplier: s, estimated_delivery_date: '2024-11-15')

      # Act - salvar
      second_order.save!

      # Assert - espero que o pedido tenha um código aleatório
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
