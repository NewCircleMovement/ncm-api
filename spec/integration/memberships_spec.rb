require 'swagger_helper'

MEMBERSHIP_PROPERTIES = {
  id: { type: :integer, decription: "ID of fruit" },
  name: { type: :string, description: "Name of fruit" },
  owner_id: { type: :integer, description: "Owner id of fruit" },
  owner_type: { type: :integer, description: "Owner type of fruit, e.g. Movement, Tribe, User" },
  monthly_yield: { type: :float, description: "Yield of memberships per month" },
  monthly_decay: { type: :float, description: "Rate of decay per month" },
}


describe 'memberships API' do

  path '/api/v1/epicenters/{epicenter_type}/{epicenter_id}/memberships' do

    get 'Retrieves list of epicenter memberships' do
      tags 'memberships'
      response '200', 'memberships retrieved' do
        parameter name: :epicenter_type, :in => :path, :type => :string
        parameter name: :epicenter_id, :in => :path, :type => :string
        run_test!
      end      
    end

    post 'Creates a membership for the corresponding epicenter' do
      tags 'memberships'
      consumes 'application/json'
      parameter name: :membership, in: :body, schema: {
        type: :object,
        properties: MEMBERSHIP_PROPERTIES,
        required: [ 'name', 'monthly_decay' ]
      }

      response '201', 'membership created' do
        let(:membership) { { name: 'Membership Name' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:membership) { { monthly_yield: 100 } }
        run_test!
      end
    end

  end

  path '/api/v1/epicenters/{epicenter_type}/{epicenter_id}/memberships/{membership_id}/enrol/{applicant_type}/{applicant_id}' do

    post 'Creates a membership for the corresponding membership and applicant' do
      tags 'memberships'
      consumes 'application/json'

      response '201', 'membership created' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  # path '/api/v1/memberships/{id}' do

  #   put "Updates a fruit by ID" do
  #     tags 'memberships'
  #     produces 'application/json'
  #     consumes 'application/json'
  #     parameter name: :id, :in => :path, :type => :integer
  #     parameter name: :fruit, :in => :body, schema: {
  #       type: :object,
  #       properties: FRUIT_PROPERTIES,
  #       required: [ 'name', 'owner_id', 'owner_type' ]
  #     }

  #     response '200', 'fruit updated' do
  #       let(:id) { fruit.create(name: 'Egon Olsen').id }
  #       let(:fruit) { { data: { :property => 'property content' } } }
  #       run_test!
  #     end
  #   end

  #   get 'Retrieves a fruit by ID' do
  #     tags 'memberships'
  #     produces 'application/json'
  #     parameter name: :id, :in => :path, :type => :integer

  #     response '200', 'fruit found' do
  #       schema type: :object,
  #         properties: FRUIT_PROPERTIES,
  #         required: [ 'id', 'name' ]

  #       let(:id) { fruit.create(name: 'Egon Olsen').id }
  #       run_test!
  #     end

  #     response '200', 'fruit not found' do
  #       let(:id) { 'invalid' }
  #       run_test!
  #     end

  #   end
  # end

  
end