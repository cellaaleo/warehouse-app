require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe 'valid?' do
    it 'name is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Ltda', brand_name: 'Samsung', registration_number: '34333444/3000-40',
                                full_address: 'Av. Nações Unidas, 343', city: 'São Paulo', state: 'SP', email: 'contato@samsung.com.br')

      pm = ProductModel.new(name: '', weigth: 8000, width: 70, heigth: 45, 
                                depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
      # Act
      result = pm.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'sku is mandatory' do
      # Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Ltda', brand_name: 'Samsung', registration_number: '34333444/3000-40',
                                full_address: 'Av. Nações Unidas, 343', city: 'São Paulo', state: 'SP', email: 'contato@samsung.com.br')

      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, heigth: 45, 
                                depth: 10, sku: '', supplier: supplier)
      # Act
      result = pm.valid?
      # Assert
      expect(result).to eq(false)
    end
  end   
end
