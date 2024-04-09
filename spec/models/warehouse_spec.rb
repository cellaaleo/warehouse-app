require 'rails_helper'
#o rspec está descrevendo os testes pra classe warehouse, e essa classe é do tipo model
RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do   # context --> para organizar os testes
      it 'false when name is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'', code:'RIO', city: 'Rio de Janeiro', 
                                  description: 'alguma descrição', address: 'Endereço', 
                                  cep: '25000-000', area: 1000)
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end
  
      it 'false when code is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'', city: 'Rio de Janeiro', 
                                  description: 'alguma descrição', address: 'Endereço', 
                                  cep: '25000-000', area: 1000)
        # Assert # Act    -> simplificando p/ deixar mais enxuto
        expect(warehouse.valid?).to eq(false)
      end
  
      it 'false when city is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'RIO', city: '', 
                                  description: 'alguma descrição', address: 'Endereço', 
                                  cep: '25000-000', area: 1000)
        # Assert
        expect(warehouse.valid?).to eq(false)
      end
  
      it 'false when description is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'RIO', city: 'Rio de Janeiro', 
                                  description: '', address: 'Endereço', 
                                  cep: '25000-000', area: 1000)
        # Assert
        expect(warehouse.valid?).to eq(false)
      end
  
      it 'false when address is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'RIO', city: 'Rio de Janeiro', 
                                  description: 'alguma descrição', address: '', 
                                  cep: '25000-000', area: 1000)
        # Assert
        expect(warehouse.valid?).to eq(false)
      end
  
      it 'false when cep is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'RIO', city: 'Rio de Janeiro', 
                                  description: 'alguma descrição', address: 'Endereço', 
                                  cep: '', area: 1000)
        # Assert
        expect(warehouse.valid?).to eq(false)
      end
  
      it 'false when area is empty' do
        # Arrenge
        warehouse = Warehouse.new(name:'RJ', code:'RIO', city: 'Rio de Janeiro', 
                                  description: 'alguma descrição', address: 'Endereço', 
                                  cep: '25000-000', area: '')
        # Assert
        expect(warehouse.valid?).to eq(false)
      end
    end
    

    it 'false when code is already in use' do
      # Arrenge                   usamos create pra salvar o 1º no banco e conseguir usar o uniqueness
      first_warehouse = Warehouse.create(name:'RJ', code:'RIO', city: 'Rio de Janeiro', 
                                description: 'alguma descrição', address: 'Endereço', 
                                cep: '25000-000', area: 1000)

      second_warehouse = Warehouse.new(name:'Niterói', code:'RIO', city: 'Niterói', 
                                description: 'outra descrição', address: 'Avenida', 
                                cep: '25000-250', area: 1111)
      # Act
      #result = second_warehouse.valid?
      # Assert
      #expect(result).to eq false
      expect(second_warehouse).not_to be_valid
    end

  end
end

=begin
Warehouse.all --> método de classe --> no describe usa-se '.', ex: '.valid?'
w = Warehouse.find(1)
w.valid? --> método de instância  --> no describe usa-se '#', ex: '#valid?'
=end