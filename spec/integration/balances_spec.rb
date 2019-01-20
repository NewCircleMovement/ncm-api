# require 'swagger_helper'

# BALANCE_PROPERTIES = {
#   id: { type: :integer, decription: "ID of balance" },
#   holder_id: { type: :integer, description: "ID of holder entity (e.g. user id, epicenter id)" },
#   holder_type: { type: :object, description: "Type of holder entity (e.g. User)" },
#   owner_id: { type: :integer, description: "Owner" },
#   owner_type: { type: :integer, description: "Owner type" },
#   fruit_id: { type: :integer, description: "Fruit id of balance" },
#   amount: { type: :float, description: "Fruit amount of balance" }
# }


# describe 'events API' do

#   path '/api/v1/events' do

#     get 'Retrieves list of events' do
#       tags 'events'
#       response '200', 'events retrieved' do
#         run_test!
#       end      
#     end

#     post 'Creates an event' do
#       tags 'events'
#       consumes 'application/json'
#       parameter name: :event, in: :body, schema: {
#         type: :object,
#         properties: EVENT_PROPERTIES,
#         required: [ 'name' ]
#       }

#       response '201', 'event created' do
#         let(:event) { { name: 'Tinkuy' } }
#         run_test!
#       end

#       response '422', 'invalid request' do
#         let(:event) { { slug: 'tinkuy' } }
#         run_test!
#       end
#     end
#   end

#   path '/api/v1/events/{id}' do

#     put "Updates an event by ID" do
#       tags 'events'
#       produces 'application/json'
#       consumes 'application/json'
#       parameter name: :id, :in => :path, :type => :integer
#       parameter name: :event, :in => :body, schema: {
#         type: :object,
#         properties: EVENT_PROPERTIES,
#         required: [ 'name' ]
#       }

#       response '200', 'event updated' do
#         let(:id) { event.create(name: 'Egon Olsen').id }
#         let(:event) { { data: { :property => 'property content' } } }
#         run_test!
#       end
#     end

#     get 'Retrieves an event by ID' do
#       tags 'events'
#       produces 'application/json'
#       parameter name: :id, :in => :path, :type => :integer

#       response '200', 'event found' do
#         schema type: :object,
#           properties: EVENT_PROPERTIES,
#           required: [ 'id', 'name' ]

#         let(:id) { event.create(name: 'Egon Olsen').id }
#         run_test!
#       end

#       response '200', 'event not found' do
#         let(:id) { 'invalid' }
#         run_test!
#       end

#     end
#   end


#   # path '/api/v1/events/{slug}' do

#   #   get 'Retrieves an event by slug' do
#   #     tags 'events'
#   #     produces 'application/json'
#   #     parameter name: :slug, :in => :path, :type => :string

#   #     response '200', 'event found' do
#   #       schema type: :object,
#   #         properties: EVENT_PROPERTIES,
#   #         required: [ 'id', 'type', 'slug', 'name' ]

#   #       let(:slug) { event.create(type: 'Center', slug: 'tinkuy', name: 'Tinkuy').id }
#   #       run_test!
#   #     end

#   #     response '200', 'event not found' do
#   #       let(:slug) { 'invalid' }
#   #       run_test!
#   #     end
#   #   end
#   # end
  
# end