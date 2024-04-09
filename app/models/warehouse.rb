class Warehouse < ApplicationRecord
  #validates atributos                ,tipo_de_validação: true
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
end
