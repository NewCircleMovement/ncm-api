require 'swagger_helper'

describe 'Epicenters API' do

  path '/epicenters' do

    post 'Creates an Epicenter blog' do
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
        let(:blog) { { slug: 'tinkuy' } }
        run_test!
      end
    end
  end

  # path '/blogs/{id}' do

  #   get 'Retrieves a blog' do
  #     tags 'Blogs'
  #     produces 'application/json', 'application/xml'
  #     parameter name: :id, :in => :path, :type => :string

  #     response '200', 'blog found' do
  #       schema type: :object,
  #         properties: {
  #           id: { type: :integer },
  #           title: { type: :string },
  #           content: { type: :string }
  #         },
  #         required: [ 'id', 'title', 'content' ]

  #       let(:id) { Blog.create(title: 'foo', content: 'bar').id }
  #       run_test!
  #     end

  #     response '404', 'blog not found' do
  #       let(:id) { 'invalid' }
  #       run_test!
  #     end

  #     response '406', 'unsupported accept header' do
  #       let(:'Accept') { 'application/foo' }
  #       run_test!
  #     end
  #   end
  # end
end