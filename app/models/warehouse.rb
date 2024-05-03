class Warehouse < ApplicationRecord
  has_many :stock_products
  #validates atributos                ,tipo_de_validação: true
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 3 }

  def full_description
    "#{code} - #{name}"
  end
end
