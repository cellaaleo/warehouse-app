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
    it "list all warehouses" do
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
    
    it "and raise an internal error" do
      # Arrange
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      # Act
      get '/api/v1/warehouses'
      # Assert
      expect(response).to have_http_status(500)
    end
    
  end

  context "POST /api/v1/warehouses" do
    it "success" do
      # Arrange
      warehouse_params = { warehouse: {name: "Galpão da Ilha", code: "FLR", city: "Florianópolis",
                                        area: 35_000, address: "Praia do Campech, 100", cep: "88058-300",
                                        description: "Um galpão especializado na região sul" }
                         }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      #expect(response.status).to eq 201
      #expect(response).to have_http_status(:created) ou
      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Galpão da Ilha'
      expect(json_response["code"]).to eq 'FLR'
      expect(json_response["city"]).to eq 'Florianópolis'
      expect(json_response["area"]).to eq 35000
      expect(json_response["address"]).to eq 'Praia do Campech, 100'
      expect(json_response["cep"]).to eq '88058-300'
      expect(json_response["description"]).to eq 'Um galpão especializado na região sul'
    end
    
    it "fail if parameters are not complete" do
      # Arrange
      warehouse_params = { warehouse: {name: "Galpão da Ilha", code: "FLR" } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status(412)
      expect(response.body).not_to include('Nome não pode ficar em branco')
      expect(response.body).not_to include('Código não pode ficar em branco')
      expect(response.body).to include('Cidade não pode ficar em branco')
      expect(response.body).to include('Descrição do galpão não pode ficar em branco')
      expect(response.body).to include('Endereço não pode ficar em branco')
      expect(response.body).to include('CEP não pode ficar em branco')
      expect(response.body).to include('Área não pode ficar em branco')
    end
    
    it "fail if there is an internal error" do
      # Arrange - Mock => interferir na execução do código usando métodos do rspec para disparar um erro
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_params = { warehouse: { name: "Galpão da Ilha", code: "FLR", city: "Florianópolis",
                                        area: 35_000, address: "Praia do Campech, 100", cep: "88058-300",
                                        description: "Um galpão especializado na região sul" }
                          }
      # Act - postar dados completos para criar um galpão 
      post '/api/v1/warehouses', params: warehouse_params

      # Assert - algum erro 500
      expect(response).to have_http_status(500)
    end
    
  end
end
