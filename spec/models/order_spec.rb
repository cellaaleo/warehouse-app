require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange - criar um pedido com todos os campos menos o código
      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
        description: 'alguma descrição', address: 'Endereço', 
        cep: '25000-000', area: 1000)
      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
            full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
            email: 'contato@dell.com')
      order = Order.new(user: u, warehouse: w, supplier: s, estimated_delivery_date: '2024-10-25')

      # Act - salvar
      result = order.valid?

      # Assert
       expect(result).to be true
    end

    it "data estimada de entrega deve ser obrigatória" do
      # Arrange - não precisa criar os outros objetos porque a pergunta é muito específica
      order = Order.new(estimated_delivery_date: '')
      
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
    end

    it "data estimada de entrega não deve ser anterior à data do pedido" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura' # expected ["deve ser futura"] to include " deve ser futura" -> se não for exatamente =, dá erro. Portanto, atenção aos espaços
    end

    it "data estimada de entrega não deve ser igual à data do pedido" do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura'
    end
    
    it "data estimada de entrega deve ser maior que a data do pedido" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be false
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

    it "e não deve ser modificado" do
      # Arrange
      w = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city: 'Rio de Janeiro', 
        description: 'alguma descrição', address: 'Endereço', 
        cep: '25000-000', area: 1000)

      u = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')

      s = Supplier.create!(corporate_name: 'Dell Ltda', brand_name: 'Dell', registration_number: '25222555/2000-50',
            full_address: 'Av. Industrial Belgraf, 400', city: 'Eldorado do Sul', state: 'RS', 
            email: 'contato@dell.com')

      order = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now)
      original_code = order.code
      
      # Act
      order.update!(estimated_delivery_date: 1.month.from_now)

      # Assert
      expect(order.code).to eq original_code
    end
    
  end
end
