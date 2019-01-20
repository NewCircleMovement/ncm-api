require 'swagger_helper'

USER_PROPERTIES = {
  id: { type: :integer },
  slug: { type: :string },
  name: { type: :string },
  data: { type: :object }
}


describe 'users API' do

  path '/api/v1/users' do

    get 'Retrieves list of users' do
      tags 'users'
      response '200', 'users retrieved' do
        run_test!
      end      
    end

    post 'Creates an user' do
      tags 'users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: USER_PROPERTIES,
        required: [ 'name' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Egon Olsen' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { slug: 'egon_olsen' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    put "Updates an user by ID" do
      tags 'users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :integer
      parameter name: :user, :in => :body, schema: {
        type: :object,
        properties: USER_PROPERTIES,
        required: [ 'name' ]
      }

      response '200', 'user updated' do
        let(:id) { user.create(name: 'Egon Olsen').id }
        let(:user) { { data: { :property => 'property content' } } }
        run_test!
      end
    end

    get 'Retrieves an user by ID' do
      tags 'users'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'user found' do
        schema type: :object,
          properties: USER_PROPERTIES,
          required: [ 'id', 'name' ]

        let(:id) { user.create(name: 'Egon Olsen').id }
        run_test!
      end

      response '200', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end


  # path '/api/v1/users/{slug}' do

  #   get 'Retrieves an user by slug' do
  #     tags 'users'
  #     produces 'application/json'
  #     parameter name: :slug, :in => :path, :type => :string

  #     response '200', 'user found' do
  #       schema type: :object,
  #         properties: USER_PROPERTIES,
  #         required: [ 'id', 'type', 'slug', 'name' ]

  #       let(:slug) { user.create(type: 'Center', slug: 'tinkuy', name: 'Tinkuy').id }
  #       run_test!
  #     end

  #     response '200', 'user not found' do
  #       let(:slug) { 'invalid' }
  #       run_test!
  #     end
  #   end
  # end
  
end