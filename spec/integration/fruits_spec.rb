require 'swagger_helper'

FRUIT_PROPERTIES = {
  id: { type: :integer, decription: "ID of fruit" },
  name: { type: :string, description: "Name of fruit" },
  owner_id: { type: :integer, description: "Owner id of fruit" },
  owner_type: { type: :integer, description: "Owner type of fruit, e.g. Movement, Tribe, User" },
  monthly_yield: { type: :float, description: "Yield of fruits per month" },
  monthly_decay: { type: :float, description: "Rate of decay per month" },
}


describe 'fruits API' do

  path '/api/v1/fruits' do

    get 'Retrieves list of fruits' do
      tags 'fruits'
      response '200', 'fruits retrieved' do
        run_test!
      end      
    end

    post 'Creates a fruit' do
      tags 'fruits'
      consumes 'application/json'
      parameter name: :fruit, in: :body, schema: {
        type: :object,
        properties: FRUIT_PROPERTIES,
        required: [ 'name', 'owner_id', 'owner_type', 'monthly_decay' ]
      }

      response '201', 'fruit created' do
        let(:fruit) { { name: 'Blommer' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:fruit) { { slug: 'tinkuy' } }
        run_test!
      end
    end
  end

  path '/api/v1/fruits/{id}' do

    put "Updates a fruit by ID" do
      tags 'fruits'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :integer
      parameter name: :fruit, :in => :body, schema: {
        type: :object,
        properties: FRUIT_PROPERTIES,
        required: [ 'name', 'owner_id', 'owner_type' ]
      }

      response '200', 'fruit updated' do
        let(:id) { fruit.create(name: 'Egon Olsen').id }
        let(:fruit) { { data: { :property => 'property content' } } }
        run_test!
      end
    end

    get 'Retrieves a fruit by ID' do
      tags 'fruits'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'fruit found' do
        schema type: :object,
          properties: FRUIT_PROPERTIES,
          required: [ 'id', 'name' ]

        let(:id) { fruit.create(name: 'Egon Olsen').id }
        run_test!
      end

      response '200', 'fruit not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end

  
end