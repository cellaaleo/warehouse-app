require 'rails_helper'

describe "Warehouse API" do
  context "GET /api/v1/warehouses/1" do
    it "success" do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais')
      # Act
      #get('/api/v1/warehouses/1')
      get "/api/v1/warehouses/#{warehouse.id}" #melhor desta forma pois, diferentemente do SQLite, há bancos de dados que não resetam o id depois dos testes
      
      # Assert - não é teste com capybara nem teste unitário
      #expect(response).to have_http_status()
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' # se fosse eq, daria erro pois => got: "application/json; charset=utf-8" 
      #expect(response.body).to include('Aeroporto SP')
      #expect(response.body).to "alguma string" => response.body --> String em formato JSON
      json_response = JSON.parse(response.body) # método do Ruby, converte formato JSON em formato ruby (hash, por padrão)
      expect(json_response["name"]).to eq 'Aeroporto SP'
      expect(json_response["code"]).to eq 'GRU'
    end

  end
  
end
