require 'swagger_helper'

EPICENTER_PROPERTIES = {
  id: { type: :integer },
  type: { type: :string },
  parent_id: { type: [:integer, nil] },
  slug: { type: :string },
  name: { type: :string },
  description: { type: [:string, nil] }
}

describe 'Epicenters API' do

  path '/api/v1/epicenters' do

    post 'Creates an Epicenter' do
      tags 'Epicenters'
      consumes 'application/json'
      parameter name: :epicenter, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string },
          parent_id: { type: :integer },
          slug: { type: :string },
          name: { type: :string },
          description: { type: :string }
        },
        required: [ 'type', 'slug', 'name' ]
      }

      response '201', 'epicenter created' do
        let(:epicenter) { { type: 'Center', slug: 'tinkuy', name: 'Tinkuy' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:epicenter) { { slug: 'tinkuy' } }
        run_test!
      end
    end
  end

  path '/api/v1/epicenters/{id}' do

    get 'Retrieves an epicenter by ID' do
      tags 'Epicenters'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'epicenter found' do
        schema type: :object,
          properties: EPICENTER_PROPERTIES,
          required: [ 'id', 'type', 'slug', 'name' ]

        let(:id) { Epicenter.create(type: 'Center', slug: 'tinkuy', name: 'Tinkuy').id }
        run_test!
      end

      response '200', 'epicenter not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end

  path '/api/v1/epicenters/{slug}' do

    get 'Retrieves an epicenter by slug' do
      tags 'Epicenters'
      produces 'application/json'
      parameter name: :slug, :in => :path, :type => :string

      response '200', 'epicenter found' do
        schema type: :object,
          properties: EPICENTER_PROPERTIES,
          required: [ 'id', 'type', 'slug', 'name' ]

        let(:slug) { Epicenter.create(type: 'Center', slug: 'tinkuy', name: 'Tinkuy').id }
        run_test!
      end

      response '200', 'epicenter not found' do
        let(:slug) { 'invalid' }
        run_test!
      end
    end
  end
end