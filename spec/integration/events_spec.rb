require 'swagger_helper'

EVENT_PROPERTIES = {
  id: { type: :integer, decription: "Event ID" },
  slug: { type: :string, decription: "unique url slug for event page" },
  name: { type: :string, description: "Event name" },
  data: { type: :object, description: "Event data" },
  caretaker_id: { type: :integer, description: "ID of events caretaker (always a user)" },
  owner_id: { type: :integer },
  owner_type: { type: :string }
}


describe 'events API' do

  path '/api/v1/epicenters/{epicenter_type}/{epicenter_id}/events' do

    get 'Retrieves list of epicenter events' do
      tags 'events'
      parameter name: :start, in: :query, description: "start date for events to be retrieved"
      parameter name: :end, in: :query, description: "end date for events to be retrieved"
      response '200', 'events retrieved' do
        run_test!
      end      
    end

    post 'Creates an epicenter event' do
      tags 'events'
      consumes 'application/json'
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: EVENT_PROPERTIES,
        required: [ 'name', 'caretaker_id', 'slug' ]
      }

      response '201', 'event created' do
        let(:event) { { name: 'Tinkuy' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:event) { { slug: 'tinkuy' } }
        run_test!
      end
    end
  end

  path '/api/v1/epicenters/{epicenter_type}/{epicenter_id}/events/{event_id}' do

    put "Updates an epicenter event by ID or SLUG" do
      tags 'events'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :event_id, :in => :path, :type => :integer
      parameter name: :event, :in => :body, schema: {
        type: :object,
        properties: EVENT_PROPERTIES,
        required: [ 'name', 'caretaker_id', 'slug' ]
      }

      response '200', 'event updated' do
        let(:event_id) { event.create(name: 'Egon Olsen', slug: 'event_slug', caretaker_id: 1).id }
        let(:event) { { data: { :property => 'property content' } } }
        
        run_test!
      end
    end

    get 'Retrieves an epicenter event by ID or SLUG' do
      tags 'events'
      produces 'application/json'
      parameter name: :event_id, :in => :path, :type => :integer

      response '200', 'event found' do
        schema type: :object, 
          properties: EVENT_PROPERTIES

        run_test!
      end

      response '404', 'event not found' do
        let(:id) { 'invalid' }
        
        run_test!
      end

    end
  end
  
end