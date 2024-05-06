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
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' # se fosse eq, daria erro pois => got: "application/json; charset=utf-8" 
      #expect(response.body).to include('Aeroporto SP')
      #expect(response.body).to "alguma string" => response.body --> String em formato JSON
      json_response = JSON.parse(response.body) # método do Ruby, converte formato JSON em formato ruby (hash, por padrão)
      expect(json_response["name"]).to eq 'Aeroporto SP'
      expect(json_response["code"]).to eq 'GRU'
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it "fail if warehouse not found" do
      # Arrange
      # Act
      get('/api/v1/warehouses/99999')
      # Assert
      expect(response.status).to eq 404
    end
  end
  
  context "GET /api/v1/warehouses" do
    it "success" do
      # Arrange
      first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                          address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                          description: 'Galpão destinado a cargas internacionais')
      second_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                                            address: 'Avenida dos Jacarés, 2555', cep: '56000-000',
                                            description: 'Galpão no centro do país')
      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq 'Aeroporto SP'
      expect(json_response[1]["name"]).to eq 'Cuiabá'
    end

    it "return empty if there is no warehouse" do
      # Arrange
      # Act
      get '/api/v1/warehouses'
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    
  end
end
