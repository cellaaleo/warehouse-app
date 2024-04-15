require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      # Arrange
      u = User.new(name: 'Maggie Regina', email: 'maggie@email.com')#, password: 'auauauau')

      # Act
      result = u.description

      # Assert
      expect(result).to eq('Maggie Regina - maggie@email.com')
    end
  end
end
