require 'json'

namespace :data do

  task :sync_events => :environment do
    tinkuy_events_endpoint = "https://tinkuy.dk/events.json"

    tinkuy = Tribe.find_by(slug: 'tinkuy')

    # payload = { email: params['login']['email'], password: params['login']['password'] }
    # headers = { :Authorization => "Token #{NCM_API_TOKEN}" }

    response = RestClient.get(tinkuy_events_endpoint)
    body = JSON.parse(response.body)
    for e in body
      slug = "#{e['id']}-#{e['name'].parameterize}"
      event = Event.find_or_create_by(id: e['id'])
      if event.new_record?
        puts "updating event: #{e['name']}"
        input = {
          slug: slug,
          name: e['name'],
          data: {
            duration: e['duration'],
            description: e['description']
          },
          caretaker_id: e['user_id'],
          owner_id: tinkuy.id,
          owner_type: tinkuy.type,
          date: e['startdate'],
          time: e['starttime']
        }
        event.attributes = input
        event.save!
      end
      
    end
  end

  task :sync_users => :environment do
    
  end


end

def get_ncm_users
  ncm_users_endpoint = "https://www.newcirclemovement.org/api/v1/epicenters/new_circle_movement/users"
  ncm_api_token = Rails.application.credentials.ncm[:ncm_api_token]
  headers = { :Authorization => "Token #{ncm_api_token}" }
  response = RestClient::Request.execute(method: :get, url: ncm_users_endpoint, headers: headers)
  return JSON.parse(response.body)
end


def get_tinkuy_users
  tinkuy_users_endpoint = "https://www.tinkuy.dk/api/v1/users"
  api_admin_user = Rails.application.credentials.tinkuy[:api_admin_user]
  api_admin_password = Rails.application.credentials.tinkuy[:api_admin_password]
  response = RestClient::Request.execute(method: :get, url: tinkuy_users_endpoint, user: api_admin_user, password: api_admin_password)
  return JSON.parse(response.body)
end